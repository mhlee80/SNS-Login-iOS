//
//  GoogleLoginService+Rx.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import GoogleSignIn
import Firebase

extension Reactive where Base: GoogleLoginService {
  func login(from view: UIViewController) -> Observable<GIDGoogleUser> {
    return Observable<GIDGoogleUser>.create { observer -> Disposable in
      self.base.login(from: view) { user, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        observer.onNext(user!)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
