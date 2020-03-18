//
//  KakaoLoginService+LoginScreen.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import RxSwift
import KakaoOpenSDK

extension Reactive where Base: KakaoLoginService {
  func login(from loginScreenView: LoginScreenViewProtocol) -> Observable<KakaoLoginService.LoginResult> {
    return self.login(from: loginScreenView as! UIViewController)
  }
}
