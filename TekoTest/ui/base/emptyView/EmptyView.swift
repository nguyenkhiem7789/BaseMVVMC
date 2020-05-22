//
//  Dove
//
//  Created by Nguyen on 6/24/19.
//  Copyright © 2019 Apple. All rights reserved.
//

import Foundation
import UIKit

class EmptyView: UIView {

    @IBOutlet weak var messageLabel: UILabel!

    var containerView: UIView!

    static let shared: EmptyView = EmptyView()

    var loadDataListener: (() -> (Void))?

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
        containerView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    }

    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EmptyView", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

    func show(view: UIView, message: String? = nil) {
        containerView.frame = view.bounds
        view.addSubview(containerView)
        if let message = message {
            messageLabel.text = message
        } else {
            messageLabel.text = "Không có dữ liệu".localized
        }
    }

    @IBAction func clickLoadDataButton(_ sender: Any) {
        loadDataListener?()
    }

    func hide() {
        containerView.removeFromSuperview()
    }
}
