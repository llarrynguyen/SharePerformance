//
//  SuperSimpleLableView.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/23/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class SuperSimpleLableView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var onlyLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        
        let name = String(describing: type(of: self))
        let nib = UINib(nibName: name, bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        contentView.pinch(self)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
