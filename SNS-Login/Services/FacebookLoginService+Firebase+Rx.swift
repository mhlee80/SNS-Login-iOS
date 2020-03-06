//
//  FacebookLoginService+Firebase+Rx.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/06.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import FBSDKCoreKit
import Firebase

extension Reactive where Base: FacebookLoginService {
  func firebaseSignIn(accessToken: AccessToken) -> Observable<AuthDataResult> {
    return Observable<AuthDataResult>.create { observer -> Disposable in
      self.base.firebaseSignIn(accessToken: accessToken) { authResult, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        observer.onNext(authResult!)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
