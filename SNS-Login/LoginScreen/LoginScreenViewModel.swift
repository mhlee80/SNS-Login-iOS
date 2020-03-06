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
    GoogleLoginService.shared.rx.login(from: view).subscribe(onNext: { user in
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
    }, onError: { error in
      log.info("error: \(error)")
    }).disposed(by: disposeBag)
  }
  
  func presentFacebookLoginFrom(_ view: LoginScreenViewProtocol) {
    FacebookLoginService.shared.rx.login(from: view, permissions: ["public_profile"]).subscribe(onNext: { result in
      if result.isCancelled {
        log.info("facebook login is canncelled")
        return
      }
      
      log.info("facebook login success: \(result)")
    }, onError: { error in
      log.info("error: \(error)")
    }).disposed(by: disposeBag)
  }
  
  func presentKakaoLoginFrom(_ view: LoginScreenViewProtocol) {
    KakaoLoginService.shared.rx.login(from: view).subscribe(onNext: { token in
      log.info("kakao login success: \(token)")
    }, onError: { error in
      log.info("error: \(error)")
    }).disposed(by: disposeBag)
  }
  
  func presentGoogleFirebaseLoginFrom(_ view: LoginScreenViewProtocol) {
    GoogleLoginService.shared.rx.login(from: view).flatMap { user -> Observable<AuthDataResult> in
      log.info("google login success: \(user.profile.email ?? "nil")")
      return GoogleLoginService.shared.rx.firebaseSignIn(authentication: user.authentication)
    }.subscribe(onNext: { authResult in
      log.info("firebase login success: \(authResult.user.email ?? "nil")")
    }, onError: { error in
      log.info("error: \(error)")
    }).disposed(by: disposeBag)
  }
}
