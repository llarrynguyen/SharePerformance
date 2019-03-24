//
//  TwoStateCardView.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/23/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class TwoStateCardView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var topMiniCardView: MiniCardView!
    @IBOutlet weak var guidingLabel: UILabel!
    @IBOutlet weak var bottomCardView: CardView!
    
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
        translatesAutoresizingMaskIntoConstraints = false
       
    }
    
}
