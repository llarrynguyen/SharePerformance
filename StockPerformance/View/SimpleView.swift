//
//  SimpleView.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/3/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

@IBDesignable open class SimpleView: UICollectionReusableView {
    
    @IBInspectable public var title: String = "" {
        didSet{
            titleLabel.text = title
        }
    }
    
    
    @IBInspectable public var titleColor: UIColor = .white {
        didSet{
            titleLabel.tintColor = titleColor
        }
    }
    
  
    
    @IBInspectable public var titleSize: CGFloat = 30
    
    @IBInspectable public var titleFont: String = "SFProDisplay-Heavy"
    
    
    private var titleLabel = UILabel ()
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        self.addSubview(titleLabel)
    }
    
    override open func draw(_ rect: CGRect) {
        
        //Draw
        super.draw(rect)
        
        titleLabel.text = title
        titleLabel.font = UIFont(name: titleFont, size: titleSize)
        titleLabel.shadowColor = UIColor.black
        titleLabel.shadowOffset = CGSize.zero
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = titleColor
        
        titleLabel.frame = CGRect(x:Resources.Sizes.standardInset,
                                  y: 0,
                                  width: 200,
                                  height:40)
        titleLabel.center.y = self.center.y
        layoutIfNeeded()
    }
}

