//
//  FacebookLoginService+LoginScreen.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import RxSwift
import FBSDKLoginKit

extension Reactive where Base: FacebookLoginService {
  func login(from loginScreenView: LoginScreenViewProtocol, permissions: [String]) -> Observable<LoginManagerLoginResult> {
    return self.login(from: loginScreenView as! UIViewController, permissions: permissions)
  }
}
