//
//  SearchView.swift
//  StockPerformance
//
//  Created by Larry Nguyen on 3/3/19.
//  Copyright © 2019 Larry. All rights reserved.
//

import UIKit

import UIKit

@IBDesignable open class SearchView: BaseView {
    
    @IBInspectable public var title: String = "" {
        didSet{
            titleLabel.text = title
        }
    }
    
    @IBInspectable public var subTitle: String = "" {
        didSet{
            subTitleLabel.text = subTitle
        }
    }
    
    @IBInspectable public var buttonTitle: String = "" {
        didSet{
            actionButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    @IBInspectable public var timeString: String = "" {
        didSet{
            timeLabel.text = timeString
        }
    }
    
    
    @IBInspectable public var mainImage: UIImage? {
        didSet{
            topImageView.image = mainImage
        }
    }
    
    @IBInspectable public var signalImage: UIImage? {
        didSet{
            signalImageView.image = mainImage
        }
    }
    
    @IBInspectable public var mainImageUrl: URL? {
        didSet{
            if let url = mainImageUrl {
                topImageView.download(from: url)
            }
            
        }
    }
    
    @IBInspectable public var titleColor: UIColor = .green {
        didSet{
            titleCol = titleColor
        }
    }
    
    @IBInspectable public var subtitleColor: UIColor = .white {
        didSet {
            subtitleCol = subtitleColor
        }
    }
    
    @IBInspectable public var bottomViewColor: UIColor = .black {
        didSet {
            bottomViewCol = bottomViewColor
        }
    }
    
    @IBInspectable public var actionColor: UIColor = .cyan {
        didSet {
            actionButton.backgroundColor = actionColor
        }
    }
    
    @IBInspectable public var titleSize: CGFloat = 22
    
    @IBInspectable public var titleFont: String = "SFProDisplay-Heavy"
    
    @IBInspectable public var subtitleSize: CGFloat = 18
    
    @IBInspectable public var subtitleFont: String = "SFProText-Regular"
    
    
    private var titleLabel = UILabel ()
    private var subTitleLabel = UILabel()
    var topImageView = UIImageView()
    var signalImageView = UIImageView()
    private var titleCol = UIColor.white
    private var subtitleCol = UIColor.white
    private var bottomViewCol = UIColor.black
    private var bottomView = UIView()
    private var actionButton = UIButton()
    private var timeLabel = UILabel()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override  func initialize() {
        super.initialize()
        bottomView.addSubview(signalImageView)
        bottomView.addSubview(timeLabel)
        bottomView.addSubview(actionButton)
        backgroundIV.addSubview(topImageView)
        backgroundIV.addSubview(titleLabel)
        backgroundIV.addSubview(subTitleLabel)
        backgroundIV.addSubview(bottomView)
       

    }
    
    override open func draw(_ rect: CGRect) {
        
        //Draw
        super.draw(rect)
        
        titleLabel.text = title
        titleLabel.font = UIFont(name: subtitleFont, size: subtitleSize)
        titleLabel.shadowColor = UIColor.black
        titleLabel.shadowOffset = CGSize.zero
        titleLabel.textAlignment = .left
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        titleLabel.textColor = titleCol
        
        subTitleLabel.text = title
        subTitleLabel.font = UIFont(name: subtitleFont, size: subtitleSize)
        subTitleLabel.shadowColor = UIColor.black
        subTitleLabel.shadowOffset = CGSize.zero
        subTitleLabel.textAlignment = .left
        subTitleLabel.lineBreakMode = .byWordWrapping
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textColor = subtitleCol
        
        signalImageView.layer.cornerRadius = signalImageView.frame.height/2
        signalImageView.image = signalImage
        
        timeLabel.text = timeString
        timeLabel.font = UIFont(name: subtitleFont, size: subtitleSize)
        timeLabel.textColor = UIColor.white
        timeLabel.shadowOffset = CGSize.zero
        timeLabel.textAlignment = .left
        timeLabel.lineBreakMode = .byWordWrapping
        timeLabel.numberOfLines = 0
        
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.backgroundColor = actionColor
        actionButton.tintColor = UIColor.white
        actionButton.layer.cornerRadius = actionButton.frame.height/2
        
        topImageView.image = mainImage
        
        self.layout()
        
    }
    
    override func layout(animating: Bool = true) {
        super.layout(animating: animating)
        let layoutService  = LayoutManager(rect: self.bounds)
        topImageView.frame = self.frame
        
        bottomView.frame = CGRect(x: 0, y: layoutService.Y(80, from: self), width: layoutService.width(100), height: layoutService.height(1/6))
        let bottomViewLayoutService = LayoutManager(rect: bottomView.bounds)
        
        signalImageView.frame = CGRect(x: insets, y: 0, width: 40, height: 40)
        signalImageView.center.y = bottomView.center.y
        
        timeLabel.frame = CGRect(x: insets*2 + signalImageView.frame.width , y: 0, width: 40, height: 15)
        timeLabel.center.y = signalImageView.center.y
        
        actionButton.frame = CGRect(x: insets, y: 0, width: 120, height: signalImageView.frame.height)
        actionButton.center.y = signalImageView.center.y
        
        subTitleLabel.frame = CGRect(x: insets,
                                     y: bottomViewLayoutService.ReverseY(10, height: 40),
                                      width: layoutService.width(100),
                                      height: layoutService.height(7))
        
        titleLabel.frame = CGRect(x:insets,
                                  y: bottomViewLayoutService.ReverseY(10, height: 60),
                                  width: layoutService.width(100),
                                  height:layoutService.height(12))
        
    }
    
}
