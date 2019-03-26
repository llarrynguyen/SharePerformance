//
//  SPYouViewController.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 2/26/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit
import CardParts

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


class SPYouViewController: CardsViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
        
        let navImageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        navImageView.image = UIImage(named: "leaf.png")
        self.navigationItem.titleView = navImageView
        self.navigationController?.navigationBar.barTintColor = UIColor.black
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

