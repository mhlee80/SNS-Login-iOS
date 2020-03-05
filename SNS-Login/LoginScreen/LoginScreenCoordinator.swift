//
//  LoginScreenCoordinator.swift
//  SNS-Login
//
//  Created by mhlee on 2020-03-02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import FBSDKLoginKit
import KakaoOpenSDK
import RxSwift

class LoginScreenCoordinator: NSObject, LoginScreenCoordinatorProtocol {
  static func createModule() -> LoginScreenViewProtocol {
    let view = LoginScreenView()
    let viewModel = LoginScreenViewModel()
    let coordinator = LoginScreenCoordinator()

    view.viewModel = viewModel
    viewModel.coordinator = coordinator

    return view
  }

  func presentKakaoLoginFrom(_ view: LoginScreenViewProtocol) {
    guard let sourceView = view as? UIViewController else { return }
    
    guard let session = KOSession.shared() else {
        return
    }

    if session.isOpen() {
        session.close()
    }

    session.presentingViewController = sourceView
    
    session.open { error in
      if !session.isOpen() {
        if let error = error {
          log.info(error)
          return
        }
        log.info("unknown error")
        return
      }
      
      if let token = session.token?.accessToken {
        log.info("access token: \(token)")
      }
    }
  }
}
