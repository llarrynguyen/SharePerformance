//
//  SPSearchViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/26/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SPSearchViewController: UIViewController {
    
    
    weak var collectionView: UICollectionView!
    weak var searchBar: UISearchBar!
    private var searchViewModel: SPSearchViewModel?
    
    override func loadView() {
        super.loadView()
        setupCollectionView()
        setupSearchUI()
        setupViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let viewModel = viewModel as? SPSearchViewModel {
            searchViewModel = viewModel
            viewModel.delegate = self
        }
        
        self.searchBar.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .clear
        self.collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: Resources.reusableIdentifiers.searchCell)
        self.collectionView.register(SimpleView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Resources.reusableIdentifiers.simpleView)
    }
    
    fileprivate func setupSearchUI(){
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 40, width: self.view.frame.width, height: 40))
       
        self.view.addSubview(searchBar)
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
            ])
        
        self.searchBar = searchBar
        self.searchBar.placeholder = ConstantTexts.PlaceHolder.searchPlaceholder
        
    }
    
    fileprivate func setupCollectionView(){
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        self.collectionView = collectionView
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
        if let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Resources.reusableIdentifiers.simpleView, for: indexPath) as? SimpleView {
            view.backgroundColor = UIColor.white
            return view
        }
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

