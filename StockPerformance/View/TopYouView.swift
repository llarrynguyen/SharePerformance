//
//  TopYouView.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/24/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class TopYouView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bottomView: YouHeaderBottomView!
    
    fileprivate var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 24
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 94, height: 94)
        return layout
    }()
    
    private let topBarAnimation = CABasicAnimation(keyPath: "position")
    private var stopBarAnimating = false
    
    @IBOutlet weak var cellCollectionView: UICollectionView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView(){
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        contentView.pinch(self)
        self.backgroundColor = UIColor.black
        self.layer.cornerRadius  = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowColor = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
        
        self.cellCollectionView.register(YouTopCollectionViewCell.self, forCellWithReuseIdentifier: Resources.reusableIdentifiers.youTopHeaderCell)
        self.cellCollectionView.dataSource    = self
        self.cellCollectionView.delegate     = self
        self.cellCollectionView.setCollectionViewLayout(collectionViewLayout, animated: true)
        self.cellCollectionView.showsHorizontalScrollIndicator = true
        self.cellCollectionView.bounces = true
        self.cellCollectionView.translatesAutoresizingMaskIntoConstraints  = false
        self.cellCollectionView.isScrollEnabled = true
        self.cellCollectionView.backgroundColor = UIColor.clear
        self.cellCollectionView.contentOffset.x = 16
        self.cellCollectionView.contentInset.left = 1
        self.cellCollectionView.contentInset.right = 1
        
        self.topBarAnimation.isAdditive = true
        self.topBarAnimation.fromValue = NSValue(cgPoint: CGPoint(x: 0, y: -4.0))
        self.topBarAnimation.toValue = NSValue(cgPoint: CGPoint(x: 0.0, y: 4.0))
        self.topBarAnimation.autoreverses  = true
        self.topBarAnimation.duration = 1.5
        self.topBarAnimation.repeatCount = Float.infinity
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if !stopBarAnimating {
            bottomView.handleView.layer.add(topBarAnimation, forKey: "topBarAnimation")
        }
    }
    
    func pauseAnimation() {
        bottomView.handleView.layer.removeAllAnimations()
        stopBarAnimating = true
    }
}

extension TopYouView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}
