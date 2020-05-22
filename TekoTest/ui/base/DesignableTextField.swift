//
//  DesignableTextField.swift
//  TekoTest
//
//  Created by Nguyen on 5/22/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableTextField: UITextField {

    private lazy var leftImageView: UIImageView = {
        return UIImageView()
    }()

    private lazy var rightImageView: UIImageView = {
        return UIImageView()
    }()

    @IBInspectable open var borderWidth: CGFloat = 1.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }

    @IBInspectable open var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }

    @IBInspectable open var bgColor: UIColor = UIColor.white {
        didSet {
            self.layer.backgroundColor = bgColor.cgColor
        }
    }

    @IBInspectable open var cornerRadius: CGFloat = 8.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    @IBInspectable open var leftImage: UIImage? {
        didSet {
            self.leftImageView.image = leftImage
        }
    }

    @IBInspectable open var rightImage: UIImage? {
        didSet {
            self.rightImageView.image = rightImage
        }
    }

    @IBInspectable open var widthImage: CGFloat = 40.0 {
        didSet {
            leftImageView.frame = CGRect(x: 0.0, y: 0.0, width: widthImage, height: self.frame.size.height)
            rightImageView.frame = CGRect(x: self.frame.size.width - widthImage, y: 0.0, width: widthImage, height: self.frame.size.height)
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

    private func initView() {
        ///property
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
        self.layer.backgroundColor = bgColor.cgColor
        self.layer.cornerRadius = cornerRadius

        ///left image
        leftImageView.frame = CGRect(x: 0.0, y: 0.0, width: widthImage, height: self.frame.size.height)
        leftImageView.contentMode = .center
        self.addSubview(leftImageView)

        ///left padding
        let leftPaddingView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: widthImage, height: self.frame.size.height))
        self.leftViewMode = .always
        self.leftView = leftPaddingView

        ///right image
        rightImageView.frame = CGRect(x: self.frame.size.width - widthImage, y: 0.0, width: widthImage, height: self.frame.size.height)
        rightImageView.contentMode = .center
        self.addSubview(rightImageView)

        ///right padding
        let rightPaddingView = UIView(frame: CGRect(x: self.frame.size.width - widthImage, y: 0.0, width: widthImage, height: self.frame.size.height))
        self.rightViewMode = .always
        self.rightView = rightPaddingView


    }

}
