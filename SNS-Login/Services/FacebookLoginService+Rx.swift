//
//  FacebookLoginService+Rx.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import FBSDKLoginKit

extension Reactive where Base: FacebookLoginService {
  func login(from view: UIViewController, permissions: [String]) -> Observable<LoginManagerLoginResult> {
    return Observable<LoginManagerLoginResult>.create { observer -> Disposable in
      self.base.login(from: view, permissions: permissions) { result, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        observer.onNext(result!)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
