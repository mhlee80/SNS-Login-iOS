//
//  LoginScreenView.swift
//  SNS-Login
//
//  Created by mhlee on 2020-03-02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginScreenView: UIViewController, LoginScreenViewProtocol {
  private var disposeBag = DisposeBag()
  
  var viewModel: LoginScreenViewModelProtocol? {
    didSet {
      setupBind()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.

    DispatchQueue.main.async { [weak self] in
      self?.viewModel?.viewDidLoad()
    }
  }
  
  private func setupBind() {
    disposeBag = DisposeBag()
  }
}
