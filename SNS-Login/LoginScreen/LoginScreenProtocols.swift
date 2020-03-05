//
//  LoginScreenProtocols.swift
//  SNS-Login
//
//  Created by mhlee on 2020-03-02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation

//typealias Completion<T> = ((T?, Error?) -> Void)

protocol LoginScreenCoordinatorProtocol {
  static func createModule() -> LoginScreenViewProtocol
  
  func presentFacebookLoginFrom(_ view: LoginScreenViewProtocol)
  func presentKakaoLoginFrom(_ view: LoginScreenViewProtocol)
}

protocol LoginScreenViewProtocol {
  var viewModel: LoginScreenViewModelProtocol? { get set }
}

protocol LoginScreenViewModelProtocol {
  var coordinator: LoginScreenCoordinatorProtocol? { get set }
  
  func viewDidLoad()
  func presentGoogleLoginFrom(_ view: LoginScreenViewProtocol)
  func presentFacebookLoginFrom(_ view: LoginScreenViewProtocol)
  func presentKakaoLoginFrom(_ view: LoginScreenViewProtocol)
}
