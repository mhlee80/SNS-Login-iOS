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

class LoginScreenCoordinator: NSObject, LoginScreenCoordinatorProtocol {
  static func createModule() -> LoginScreenViewProtocol {
    let view = LoginScreenView()
    let viewModel = LoginScreenViewModel()
    let coordinator = LoginScreenCoordinator()

    view.viewModel = viewModel
    viewModel.coordinator = coordinator

    return view
  }
  
  func presentGoogleSignInFrom(_ view: LoginScreenViewProtocol) {
    guard let sourceView = view as? UIViewController else { return }
    
    GIDSignIn.sharedInstance()?.presentingViewController = sourceView
    GIDSignIn.sharedInstance()?.signIn()
  }
  
  func presentFacebookLoginFrom(_ view: LoginScreenViewProtocol) {
    guard let sourceView = view as? UIViewController else { return }
    
    let loginManager = LoginManager()
    loginManager.logIn(permissions: ["public_profile"], from: sourceView) { result, error in
      if let error = error {
        log.info(error)
        return
      }
      
      if let result = result {
        log.info("facebook login: \(result)")
      }
    }
    
  }
}
