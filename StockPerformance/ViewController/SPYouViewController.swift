//
//  SPYouViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/26/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit
import CardParts

let screenWidth: CGFloat = UIScreen.main.bounds.width
let screenHeight: CGFloat = UIScreen.main.bounds.height
let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height

fileprivate class EndlessScrollView: UIScrollView {
    var loopable: Bool = true
    var pageWidth: CGFloat = 0.0
    var canGoBackwardAtStart = false
    override func layoutSubviews() {
        super.layoutSubviews()
        
        var currentOffset = contentOffset
        if let parent = self.parentViewController as? SPYouViewController, parent.pageControl.numberOfPages > 0 {
          
            if currentOffset.x < 0 && canGoBackwardAtStart {
                currentOffset.x = contentSize.width - frame.width
                contentOffset  = currentOffset
                parent.pageControl.resetIndicatorToEndPostion()
                parent.pageControl.currentPage = parent.pageControl.numberOfPages - 2
                
            } else if currentOffset.x > contentSize.width - frame.width {
                //currentOffset.x = parent.content
            }
        }
    }
}

class SPYouPieceViewController: CardsViewController {
    fileprivate(set) var cards = [CardController]()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(cards: [CardController]){
        self.init(nibName: nil, bundle: nil)
        self.cards = cards
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if cards.count == 0 {
            return
        }
        
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator  = false
        self.view.backgroundColor = .clear
        self.collectionView.contentInset.bottom += 10
        self.collectionView.contentInset.top = 18
        
        loadCards(cards: cards)
    }
}



class SPYouViewController: UIViewController, UIScrollViewDelegate {
    
    private var youViewModel: SPYouViewModel?
    
    fileprivate var pageControl = FlexiblePageControl()
    private var scrollView: EndlessScrollView!
    private var originalContentOffset: CGPoint = .zero
    private var topView: TopYouView!
    
    private var topViewHeightConstraint: NSLayoutConstraint!
    private var topViewToViewConstraint: NSLayoutConstraint!
    private var originalTopViewTopConstant: CGFloat = 0
    private var horizontalBar: UIView!
    private var circleView: UIView!
    private var blurImageView: UIView!
    
    fileprivate let collectionView = CardPartCollectionView(collectionViewLayout: UICollectionViewFlowLayout())
    private let hapticFeedback = UISelectionFeedbackGenerator()
    
    
    private var childControllers = [SPYouPieceViewController]()
    
    private var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 94, height: 120)
        return layout
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        let navImageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        navImageView.image = UIImage(named: "leaf.png")
        self.navigationItem.titleView = navImageView
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        initialLoad()
    }
    
    private func setupCollectionView(){
        
    }
    
    
    private func initialLoad() {
        scrollView = EndlessScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView.backgroundColor = .clear
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator  = false
        scrollView.alwaysBounceVertical = false
        scrollView.decelerationRate  = .fast
        scrollView.delaysContentTouches  = false
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.delegate = self
        view.setNeedsUpdateConstraints()
        scrollView.invalidateIntrinsicContentSize()
        scrollView.setNeedsLayout()
        scrollView.layoutIfNeeded()
        constraintScrollview()
    }
    
    
    private func constraintScrollview() {
        let top = view.topAnchor
        let bottom = view.bottomAnchor
         NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: top, constant: 10),
            scrollView.bottomAnchor.constraint(equalTo: bottom, constant: -10)
        ])
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollView]-0-|", options: [], metrics: nil, views: ["scrollView" : scrollView]))
    }
    
    private func setTopView(){
        let startHeaderVisibleHeight: CGFloat = 90
        var startHeaderPositionY = startHeaderVisibleHeight - screenHeight
        
        topView = TopYouView(frame: CGRect(x: 0, y: startHeaderPositionY, width: screenWidth, height: screenHeight))
    
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(slideTopViewDown))
        topView.bottomView.addGestureRecognizer(gesture)
        
        let coverBar = UIView(frame: CGRect(x: 0, y: statusBarHeight - 95, width: screenWidth, height: 95))
        view.addSubview(coverBar)
        view.addSubview(topView)
        
        var top = view.topAnchor
        
        top = view.safeAreaLayoutGuide.topAnchor
        startHeaderPositionY -= 20
        
        
    }
    
    @objc func slideTopViewDown(_ gesture: UIPanGestureRecognizer){
        let location = gesture.location(in: self.view)
        let velocity = gesture.velocity(in: self.view)
        
        if gesture.state == .ended {
            if velocity.y > 0 {
                pullTopViewDown()
            } else {
                pushTopViewUp()
            }
            
            topView.pauseAnimation()
            return
        } else {
            let y = topViewToViewConstraint.constant + location.y
            if y <= originalTopViewTopConstant || abs(originalTopViewTopConstant - y) >= 290 {
                return
            }
            topViewToViewConstraint.constant = y
            gesture.setTranslation(.zero, in: self.view)
        }
    }
    
    private func pushTopViewUp(){
        topViewToViewConstraint.constant = originalTopViewTopConstant
        topView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            print("Done Animating")
        }
    }
    
    private func pullTopViewDown() {
        topViewToViewConstraint.constant = originalTopViewTopConstant + 105
        topView.setNeedsUpdateConstraints()
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            print("Done Animating")
        }
    }
    
}

extension SPYouViewController: ViewControllerable {
    var name: String {
        return ViewControllerType.youViewController
    }
    
    var tabItemImageString: String {
        return Resources.ImageNames.you
    }
    
    var viewModel: Any? {
        return SPYouViewModel(networkManager: NetworkManager())
        
    }
    
    func setupViewController() {
        self.view.backgroundColor = AppColor.mainBackgroud.value
    }
    
}

