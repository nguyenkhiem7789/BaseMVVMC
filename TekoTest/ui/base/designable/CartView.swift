//
//  CartView.swift
//  TekoTest
//
//  Created by Nguyen on 5/24/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

@IBDesignable
class CartView: UIView {

    private var cartImageView = UIImageView()

    private var circleLayer = CAShapeLayer()

    private var textLayer = CenterTextLayer()

    private var radius: CGFloat = 8.0

    private var offset: CGFloat = 4.0

    @IBInspectable open var cartImage: UIImage? {
        didSet {
            cartImageView.image = cartImage
        }
    }

    @IBInspectable
    public var circleRadius: CGFloat = 8.0 {
        didSet {
            self.radius = circleRadius
        }
    }

    @IBInspectable
    public var number: String = "10" {
        didSet {
            textLayer.string = number
        }
    }

    @IBInspectable
    public var sizeImage: CGFloat = 24.0 {
        didSet {
            cartImageView.frame = CGRect(x: self.frame.width/2 - sizeImage/2, y: self.frame.height/2 - 12, width: sizeImage, height: sizeImage)
        }
    }

    @IBInspectable
    public var sizeText: CGFloat = 20.0 {
        didSet {
            textLayer.frame = CGRect(x: self.frame.width/2, y: self.frame.height/2 - sizeText, width: sizeText, height: sizeText)
        }
    }

    @IBInspectable
    public var fontSize: CGFloat = 12.0 {
        didSet {
            textLayer.fontSize = fontSize
        }
    }

    @IBInspectable
    public var bgCircleColor: UIColor = UIColor.red {
        didSet {
            textLayer.backgroundColor = bgCircleColor.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }

    func initView() {
        ///cart image view
        cartImageView.frame = CGRect(x: self.frame.width/2 - sizeImage/2, y: self.frame.height/2 - 12, width: sizeImage, height: sizeImage)
        addSubview(cartImageView)

        let centerPoint = CGPoint(x: self.frame.size.width - radius - offset, y: radius + offset)
        let circlePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: CGFloat(-(0.5 * Double.pi)), endAngle: CGFloat(1.5 * Double.pi), clockwise: true)
        circleLayer.path = circlePath.cgPath
        circleLayer.lineWidth = 3.0
        circleLayer.fillColor = UIColor.red.cgColor
//        self.layer.addSublayer(circleLayer)

        /// number text
        textLayer.frame = CGRect(x: self.frame.width/2, y: self.frame.height/2 - sizeText, width: sizeText, height: sizeText)
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.fontSize = fontSize
        textLayer.backgroundColor = bgCircleColor.cgColor
        textLayer.isWrapped = true
        textLayer.cornerRadius = sizeText/2
        textLayer.foregroundColor = UIColor.white.cgColor
        textLayer.alignmentMode = .center
        textLayer.string = number
        textLayer.masksToBounds = true
        self.layer.addSublayer(textLayer)
    }

}
