//
//  BaseViewModel.swift
//  TekoTest
//
//  Created by Nguyen on 5/21/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {

    lazy var provider: Provider = {
        return Provider()
    }()

    typealias RequestCompletion = ((_ success: Bool, _ error: String?, _ data: Any?) -> (Void))?

    public let loading: PublishSubject<Bool> = PublishSubject()

}

