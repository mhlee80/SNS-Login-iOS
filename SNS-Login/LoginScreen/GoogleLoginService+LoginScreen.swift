//
//  GoogleLoginService+LoginScreen.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import RxSwift
import GoogleSignIn

extension Reactive where Base: GoogleLoginService {
  func login(from loginScreenView: LoginScreenViewProtocol) -> Observable<GIDGoogleUser> {
    return self.login(from: loginScreenView as! UIViewController)
  }
}
