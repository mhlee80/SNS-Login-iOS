//
//  LoginScreenViewModel.swift
//  SNS-Login
//
//  Created by mhlee on 2020-03-02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import GoogleSignIn
import Firebase

class LoginScreenViewModel: NSObject, LoginScreenViewModelProtocol {
  var coordinator: LoginScreenCoordinatorProtocol?
  
  func viewDidLoad() {
    log.info("")
  }
  
  private let disposeBag = DisposeBag()
  
  func presentGoogleLoginFrom(_ view: LoginScreenViewProtocol) {
    GoogleLoginService.shared.rx.googleSignIn(from: view).flatMap { user -> Observable<AuthDataResult> in
      log.info("google login success: \(user.profile.email ?? "nil")")
      
//      let userId = user.userID
//      let idToken = user.authentication.idToken
//      let fullName = user.profile.name
//      let givenName = user.profile.givenName
//      let familyName = user.profile.familyName
//      let email = user.profile.email
//      log.info("userId: \(userId ?? "nil")")
//      log.info("idToken: \(idToken ?? "nil")")
//      log.info("fullName: \(fullName ?? "nil")")
//      log.info("givenName: \(givenName ?? "nil")")
//      log.info("familyName: \(familyName ?? "nil")")
//      log.info("email: \(email ?? "nil")")

      return GoogleLoginService.shared.rx.firebaseSignIn(authentication: user.authentication)
    }.subscribe(onNext: { authResult in
      log.info("firebase login success: \(authResult.user.email ?? "nil")")
    }, onError: { error in
      log.info("error: \(error)")
    }).disposed(by: disposeBag)
  }
  
  func presentFacebookLoginFrom(_ view: LoginScreenViewProtocol) {
    coordinator?.presentFacebookLoginFrom(view)
  }
  
  func presentKakaoLoginFrom(_ view: LoginScreenViewProtocol) {
    coordinator?.presentKakaoLoginFrom(view)
  }
}
