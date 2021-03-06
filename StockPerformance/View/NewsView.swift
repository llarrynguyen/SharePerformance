//
//  NewsView.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/24/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

class NewsView: UIView {
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var lookupButton: UIButton!
    
    @IBOutlet weak var readButton: UIButton!
    @IBOutlet var contentView: UIView!
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
    
    @IBAction func addTapped(_ sender: Any) {
    }
    @IBAction func readTapped(_ sender: Any) {
    }
    @IBAction func lookupTapped(_ sender: Any) {
    }
    
}
