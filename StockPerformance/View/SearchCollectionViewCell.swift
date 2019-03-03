//
//  SearchCollectionViewCell.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/3/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    var searchView: SearchView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        initilize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("No Interface Build has not been implemented")
    }
    
    func initilize(){
        searchView = SearchView(frame: self.frame)
        self.addSubview(searchView)
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: self.topAnchor),
            searchView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            searchView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        self.layer.cornerRadius = 10
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fatalError("No Interface Build has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        searchView = nil
    }
}
