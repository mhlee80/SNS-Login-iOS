//
//  LoginScreenViewModel.swift
//  SNS-Login
//
//  Created by mhlee on 2020-03-02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation

class LoginScreenViewModel: NSObject, LoginScreenViewModelProtocol {
  var coordinator: LoginScreenCoordinatorProtocol?
  func viewDidLoad() {
    log.info("")
  }
}
