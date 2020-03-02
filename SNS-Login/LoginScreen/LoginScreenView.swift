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
import SnapKit

class LoginScreenView: UIViewController, LoginScreenViewProtocol {
  private var disposeBag = DisposeBag()
  
  var viewModel: LoginScreenViewModelProtocol? {
    didSet {
      setupBind()
    }
  }
  
  private lazy var googleSignInButton: UIButton = {
    let v = UIButton()
    v.backgroundColor = .white
    v.layer.borderWidth = 1
    v.layer.cornerRadius = 24
    v.layer.borderColor = UIColor.black.cgColor
    v.setTitleColor(.black, for: .normal)
    v.titleLabel?.font = .systemFont(ofSize: 20)
    v.setTitle("Google Sign in", for: .normal)
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    
    view.addSubview(googleSignInButton)
    
    googleSignInButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.centerY.equalToSuperview()
      make.size.equalTo(CGSize(width: 230, height: 48))
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.viewModel?.viewDidLoad()
    }
  }
  
  private func setupBind() {
    disposeBag = DisposeBag()
    
    googleSignInButton.rx.tap.subscribe(onNext: { [weak self] in
        self?.viewModel?.presentGoogleSignInFrom(self!)
    }).disposed(by: disposeBag)
  }
}
