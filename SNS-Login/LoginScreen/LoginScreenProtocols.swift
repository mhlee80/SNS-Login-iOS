//
//  LoginScreenProtocols.swift
//  SNS-Login
//
//  Created by mhlee on 2020-03-02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation

protocol LoginScreenCoordinatorProtocol {
  static func createModule() -> LoginScreenViewProtocol
}

protocol LoginScreenViewProtocol {
  var viewModel: LoginScreenViewModelProtocol? { get set }
}

protocol LoginScreenViewModelProtocol {
  var coordinator: LoginScreenCoordinatorProtocol? { get set } 
  func viewDidLoad()
}
