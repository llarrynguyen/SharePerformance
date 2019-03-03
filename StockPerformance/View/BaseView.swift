//
//  BaseView.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/3/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

@IBDesignable open class BaseView: UIView {
    
    @IBInspectable public var textColor: UIColor = UIColor.black
    
    @IBInspectable public var shadowBlur: CGFloat = 13 {
        didSet{
            self.layer.shadowRadius = shadowBlur
        }
    }
    
    @IBInspectable public var backgroundImage: UIImage? {
        didSet{
            self.backgroundIV.image = backgroundImage
        }
    }
    
    @IBInspectable public var viewRadius: CGFloat = 20{
        didSet{
            self.layer.cornerRadius = viewRadius
        }
    }
    
    @IBInspectable public var contentInset: CGFloat = 6 {
        didSet {
            insets = LayoutManager(rect: originalFrame).width(contentInset)
        }
    }
    
    override open var backgroundColor: UIColor? {
        didSet(new) {
            if let color = new { backgroundIV.backgroundColor = color }
            if backgroundColor != UIColor.clear { backgroundColor = UIColor.clear }
        }
    }
    
    
    //public var delegate: GFMBaseNearbyViewDelegate?
    
    
    fileprivate var tap = UITapGestureRecognizer()
    var superVC: UIViewController?
    var originalFrame = CGRect.zero
    var backgroundIV = UIImageView()
    var insets = CGFloat()
    var isPresenting = false
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    func initialize() {
        
        self.addGestureRecognizer(tap)
        tap.cancelsTouchesInView = false
        
        self.addSubview(backgroundIV)
        backgroundIV.isUserInteractionEnabled = true
        
        if backgroundIV.backgroundColor == nil {
            backgroundIV.backgroundColor = UIColor.white
            super.backgroundColor = UIColor.clear
        }
    }
    
    override open func draw(_ rect: CGRect) {
        super.draw(rect)
        originalFrame = rect
        
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = shadowBlur
        self.layer.cornerRadius = viewRadius
        
        backgroundIV.image = backgroundImage
        backgroundIV.layer.cornerRadius = self.layer.cornerRadius
        backgroundIV.clipsToBounds = true
        backgroundIV.contentMode = .scaleAspectFill
        
        backgroundIV.frame.origin = bounds.origin
        backgroundIV.frame.size = CGSize(width: bounds.width, height: bounds.height)
        contentInset = 6
    }
    
    
    func layout(animating: Bool = true){ }
    
    
    @objc func viewTapped() {
        //TODO: if we need to activate delegate methods
    }
    
    
    private func pushBackAnimated() {
        
        UIView.animate(withDuration: 0.2, animations: { self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) })
    }
    
    private func resetAnimated() {
        
        UIView.animate(withDuration: 0.2, animations: { self.transform = CGAffineTransform.identity })
    }
    
    
}



