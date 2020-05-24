//
//  Dove
//
//  Created by Nguyen on 6/24/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class NumberView: UIView {

    @IBOutlet weak var numberLabel: UILabel!

    var containerView: UIView!

    static let shared: NumberView = NumberView()

    var loadDataListener: (() -> (Void))?

    var number: Int = 10

    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    func xibSetup() {
        // setup the view from .xib
        containerView = loadViewFromNib()
        containerView.frame = self.bounds
        containerView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(containerView)
        updateLabel()
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NumberView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    @IBAction func clickRemoveButton(_ sender: Any) {
        if number > 0 {
            number -= 1
            updateLabel()
        }
    }

    @IBAction func clickAddButton(_ sender: Any) {
        number += 1
        updateLabel()
    }

    func updateLabel() {
        numberLabel.text = String(number)
    }

    func hide() {
        containerView.removeFromSuperview()
    }
}
