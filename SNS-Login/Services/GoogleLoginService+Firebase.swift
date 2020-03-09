//
//  GoogleLoginService+Firebase.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/06.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import GoogleSignIn
import Firebase
import RxSwift

extension GoogleLoginService {
  func firebaseSignIn(authentication: GIDAuthentication, completion: ((AuthDataResult?, Error?) -> Void)?) {
    let idToken = authentication.idToken
    let accessToken = authentication.accessToken
    let credential = GoogleAuthProvider.credential(withIDToken: idToken!, accessToken: accessToken!)
    Auth.auth().signIn(with: credential) { authResult, error in
      completion?(authResult, error)
    }
  }
}

extension Reactive where Base: GoogleLoginService {
  func firebaseSignIn(authentication: GIDAuthentication) -> Observable<AuthDataResult> {
    return Observable<AuthDataResult>.create { observer -> Disposable in
      self.base.firebaseSignIn(authentication: authentication) { authResult, error in
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
