//
//  SPSearchViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/26/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPSearchViewController: UIViewController {
    weak var mainScrollView: UIScrollView!
    weak var topContainerView: UIView!
    weak var summaryView: SimpleLabelView!
    weak var chartContainerView: UIView!
    weak var collectionView: UICollectionView!
    weak var portfoliaCollectionView: UICollectionView!
    weak var topLabelView: SuperSimpleLableView!
    weak var searchBar: UISearchBar!
    weak var twoStageCardView: TwoStateCardView!
    private var searchViewModel: SPSearchViewModel?
    
    override func loadView() {
        super.loadView()
        setupScrollView()
        setupSearchUI()
        setupTopContainerView()
        setupTopCollectionView()
        setupCollectionView()
        setupViewController()
        setupBottomTwoStageCardViews()
    }
    
    lazy var collectionViewFlowLayout : AdaptableCollectionViewLayout = {
        let layout = AdaptableCollectionViewLayout(display: .inline)
        return layout
    }()
    
    lazy var portfoliaCollectionViewFlowLayout : AdaptableCollectionViewLayout = {
        let layout = AdaptableCollectionViewLayout(display: .list)
        return layout
    }()
    
    let dataSource = ColorDataSource()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel as? SPSearchViewModel {
            searchViewModel = viewModel
            viewModel.delegate = self
        }
        
        self.navigationItem.title = "Explore Stocks"
        self.navigationController?.navigationBar.isTranslucent = false
        let navImageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        navImageView.image = UIImage(named: "leaf.png")
        self.navigationItem.titleView = navImageView
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        self.mainScrollView.delegate = self
        
        self.searchBar.delegate = self
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .gray
        //self.collectionView.collectionViewLayout = collectionViewFlowLayout
        self.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: Resources.reusableIdentifiers.searchCell)
        
        self.portfoliaCollectionView.delegate = self
        self.portfoliaCollectionView.dataSource = self
        self.portfoliaCollectionView.backgroundColor = .black
        self.portfoliaCollectionView.isScrollEnabled = true
        //self.portfoliaCollectionView.collectionViewLayout = portfoliaCollectionViewFlowLayout
       
        self.portfoliaCollectionView.register(PortfoliaCollectionViewCell.self, forCellWithReuseIdentifier: Resources.reusableIdentifiers.portfolioCell)
        
        self.dataSource.data.addAndNotify(observer: self) { [weak self] in
            mainQueue {
                self?.collectionView.reloadData()
                self?.portfoliaCollectionView.reloadData()
            }
        }
        
        // get data
        self.dataSource.data.value = [.red, .orange, .cyan, .purple, .yellow, .magenta]
        //self.collectionView.register(SimpleView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Resources.reusableIdentifiers.simpleView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    fileprivate func setupScrollView(){
        let mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
       mainScrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height * 2)
        self.view.addSubview(mainScrollView)
        self.mainScrollView = mainScrollView
    }
    
    fileprivate func setupTopContainerView(){
        let topContainerView = UIView(frame: CGRect(x: 0, y: 90, width: self.view.frame.width, height: 400))
        topContainerView.backgroundColor = .blue
        self.mainScrollView.addSubview(topContainerView)

        self.topContainerView = topContainerView
        
        let summaryView = SimpleLabelView()
        summaryView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 100)
        topContainerView.addSubview(summaryView)
        NSLayoutConstraint.activate([
            summaryView.topAnchor.constraint(equalTo: self.topContainerView.topAnchor),
            summaryView.leadingAnchor.constraint(equalTo: self.topContainerView.leadingAnchor),
            summaryView.trailingAnchor.constraint(equalTo: self.topContainerView.trailingAnchor)
            ])
        
        self.summaryView = summaryView
        
        let chartContainerView = UIView(frame: CGRect(x: 0, y: 100, width: self.view.frame.width, height: 300))
        topContainerView.addSubview(chartContainerView)
        NSLayoutConstraint.activate([
            chartContainerView.topAnchor.constraint(equalTo: summaryView.bottomAnchor),
            chartContainerView.leadingAnchor.constraint(equalTo: self.topContainerView.leadingAnchor),
            chartContainerView.trailingAnchor.constraint(equalTo: self.topContainerView.trailingAnchor)
            ])
        
        self.chartContainerView = chartContainerView

    }
    
    fileprivate func setupSearchUI(){
        let topLabel = SuperSimpleLableView()
        topLabel.frame = CGRect(x: 0, y: 10, width: self.view.frame.width, height: 30)
        self.mainScrollView.addSubview(topLabel)
        NSLayoutConstraint.activate([
            topLabel.topAnchor.constraint(equalTo: self.view.topAnchor),
            topLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            topLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        self.topLabelView = topLabel
        
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 50, width: self.view.frame.width, height: 40))
        self.mainScrollView.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topLabelView.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        
        searchBar.placeholder = ConstantTexts.PlaceHolder.searchPlaceholder
        self.searchBar = searchBar
    }
    
    fileprivate func setupCollectionView(){
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.mainScrollView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.portfoliaCollectionView.bottomAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 1000),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        
        self.collectionView = collectionView
    }
    
    
    fileprivate func setupTopCollectionView(){
        let portfoliaCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        portfoliaCollectionView.translatesAutoresizingMaskIntoConstraints = false
        self.mainScrollView.addSubview(portfoliaCollectionView)
        
        NSLayoutConstraint.activate([
            portfoliaCollectionView.topAnchor.constraint(equalTo: self.topContainerView.bottomAnchor),
            portfoliaCollectionView.heightAnchor.constraint(equalToConstant: 100),
            portfoliaCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            portfoliaCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
    
        self.portfoliaCollectionView = portfoliaCollectionView
    }
    
    fileprivate func setupBottomTwoStageCardViews(){
        let cardView = TwoStateCardView()
        cardView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height * 3/4)
        self.mainScrollView.addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topMiniCardView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
            cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        
        self.twoStageCardView = cardView
        
  
    }
}

extension SPSearchViewController: ViewControllerable {
    var name: String {
        return ViewControllerType.searchViewController
    }
    
    var tabItemImageString: String {
        return Resources.ImageNames.search
    }
    
    var viewModel: Any? {
        return SPSearchViewModel(networkManager: NetworkManager())
    }
    
    func setupViewController() {
        self.view.backgroundColor = AppColor.mainBackgroud.value
    }
}

extension SPSearchViewController: SPSearchViewModelProtocol {
    func haveSearchedForKeyword() {
        mainQueue {
            self.collectionView.reloadData()
        }
    }
    
}

extension SPSearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel?.search(keywork: searchBar.text ?? "")
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
}

extension SPSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel?.searches?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}

extension SPSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
//        if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Resources.reusableIdentifiers.simpleView, for: indexPath) as? SimpleView {
//            view.backgroundColor = UIColor.white
//            return view
//        }
        return UICollectionReusableView()
    }
    
    
}

extension SPSearchViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Resources.Sizes.halfInset
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: Resources.Sizes.halfInset, left: Resources.Sizes.halfInset, bottom: Resources.Sizes.halfInset, right: Resources.Sizes.halfInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.frame.width, height: 60)
    }
}

