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

extension GoogleLoginService {
  func rxGoogleSignIn(from loginScreenView: LoginScreenViewProtocol) -> Observable<GIDGoogleUser> {
    return self.rxGoogleSignIn(from: loginScreenView as! UIViewController)
  }
}
