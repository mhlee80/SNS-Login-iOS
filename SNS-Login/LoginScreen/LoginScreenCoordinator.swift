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
}
