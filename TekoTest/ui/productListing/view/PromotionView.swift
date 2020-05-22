//
//  PercentLabel.swift
//  TekoTest
//
//  Created by Nguyen on 5/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

@IBDesignable
class PromotionView: UIView {

    let shapeLayer = CAShapeLayer()

    let textLayer = CenterTextLayer()

    @IBInspectable open var fillColor: UIColor = UIColor.gray {
        didSet {
            shapeLayer.fillColor = fillColor.cgColor
        }
    }

    @IBInspectable open var text: String? {
        didSet {
            textLayer.string = text
        }
    }

    @IBInspectable open var textColor: UIColor = UIColor.white {
        didSet {
            textLayer.foregroundColor = textColor.cgColor
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
        shapeLayer.path = bgPath().cgPath
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.lineWidth = 1.0
        shapeLayer.position = CGPoint(x: 0.0, y: 0.0)
        self.layer.addSublayer(shapeLayer)

        textLayer.frame = self.bounds
        textLayer.fontSize = 10.0
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        textLayer.foregroundColor = textColor.cgColor
        self.layer.addSublayer(textLayer)
    }

    override func layoutSubviews() {
        
    }

    func bgPath() -> UIBezierPath {
        let bgPath = UIBezierPath()
        bgPath.move(to: CGPoint(x: 0.0, y: self.frame.size.height/2))
        bgPath.addLine(to: CGPoint(x: self.frame.size.width/4, y: 0.0))
        bgPath.addLine(to: CGPoint(x: self.frame.size.width, y: 0.0))
        bgPath.addLine(to: CGPoint(x: self.frame.size.width, y: self.frame.size.height))
        bgPath.addLine(to: CGPoint(x: self.frame.size.width/4, y: self.frame.size.height))
        bgPath.close()
        return bgPath
    }
}
