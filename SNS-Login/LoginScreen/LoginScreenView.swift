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
  
  private lazy var titleLabel: UILabel = {
    let v = UILabel()
    v.backgroundColor = .white
    v.textColor = .black
    v.font = .systemFont(ofSize: 48)
    v.text = "SNS Login"
    return v
  }()
  
  private lazy var googleLoginButton: UIButton = {
    let v = UIButton()
    v.backgroundColor = .white
    v.layer.borderWidth = 1
    v.layer.cornerRadius = 24
    v.layer.borderColor = UIColor.black.cgColor
    v.setTitleColor(.black, for: .normal)
    v.titleLabel?.font = .systemFont(ofSize: 20)
    v.setTitle("Google Login", for: .normal)
    return v
  }()
  
  private lazy var facebookLoginButton: UIButton = {
    let v = UIButton()
    v.backgroundColor = .white
    v.layer.borderWidth = 1
    v.layer.cornerRadius = 24
    v.layer.borderColor = UIColor.black.cgColor
    v.setTitleColor(.black, for: .normal)
    v.titleLabel?.font = .systemFont(ofSize: 20)
    v.setTitle("Facebook Login", for: .normal)
    return v
  }()

  private lazy var kakaoLoginButton: UIButton = {
    let v = UIButton()
    v.backgroundColor = .white
    v.layer.borderWidth = 1
    v.layer.cornerRadius = 24
    v.layer.borderColor = UIColor.black.cgColor
    v.setTitleColor(.black, for: .normal)
    v.titleLabel?.font = .systemFont(ofSize: 20)
    v.setTitle("Kakao Login", for: .normal)
    return v
  }()
  
  private lazy var googleFirebaseLoginButton: UIButton = {
    let v = UIButton()
    v.backgroundColor = .white
    v.layer.borderWidth = 1
    v.layer.cornerRadius = 24
    v.layer.borderColor = UIColor.black.cgColor
    v.setTitleColor(.black, for: .normal)
    v.titleLabel?.font = .systemFont(ofSize: 20)
    v.setTitle("Google + Firebase Login", for: .normal)
    return v
  }()
  
  private lazy var facebookFirebaseLoginButton: UIButton = {
    let v = UIButton()
    v.backgroundColor = .white
    v.layer.borderWidth = 1
    v.layer.cornerRadius = 24
    v.layer.borderColor = UIColor.black.cgColor
    v.setTitleColor(.black, for: .normal)
    v.titleLabel?.font = .systemFont(ofSize: 20)
    v.setTitle("Facebook + Firebase Login", for: .normal)
    return v
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    view.backgroundColor = .white
    
    view.addSubview(titleLabel)
    view.addSubview(googleLoginButton)
    view.addSubview(facebookLoginButton)
    view.addSubview(kakaoLoginButton)
    view.addSubview(googleFirebaseLoginButton)
    view.addSubview(facebookFirebaseLoginButton)
    
    titleLabel.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.top.equalToSuperview().offset(100)
    }
    
    googleLoginButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(facebookLoginButton.snp.top).offset(-20)
      make.size.equalTo(CGSize(width: 260, height: 48))
    }
    
    facebookLoginButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(kakaoLoginButton.snp.top).offset(-20)
      make.size.equalTo(CGSize(width: 260, height: 48))
    }
    
    kakaoLoginButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(googleFirebaseLoginButton.snp.top).offset(-20)
      make.size.equalTo(CGSize(width: 260, height: 48))
    }
    
    googleFirebaseLoginButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalTo(facebookFirebaseLoginButton.snp.top).offset(-20)
      make.size.equalTo(CGSize(width: 260, height: 48))
    }
    
    facebookFirebaseLoginButton.snp.makeConstraints { make in
      make.centerX.equalToSuperview()
      make.bottom.equalToSuperview().offset(-20)
      make.size.equalTo(CGSize(width: 260, height: 48))
    }
    
    DispatchQueue.main.async { [weak self] in
      self?.viewModel?.viewDidLoad()
    }
  }
  
  private func setupBind() {
    disposeBag = DisposeBag()
    
    googleLoginButton.rx.tap.subscribe(onNext: { [weak self] in
        self?.viewModel?.presentGoogleLoginFrom(self!)
    }).disposed(by: disposeBag)
    
    facebookLoginButton.rx.tap.subscribe(onNext: { [weak self] in
        self?.viewModel?.presentFacebookLoginFrom(self!)
    }).disposed(by: disposeBag)
    
    kakaoLoginButton.rx.tap.subscribe(onNext: { [weak self] in
        self?.viewModel?.presentKakaoLoginFrom(self!)
    }).disposed(by: disposeBag)
    
    googleFirebaseLoginButton.rx.tap.subscribe(onNext: { [weak self] in
        self?.viewModel?.presentGoogleFirebaseLoginFrom(self!)
    }).disposed(by: disposeBag)
    
    facebookFirebaseLoginButton.rx.tap.subscribe(onNext: { [weak self] in
        self?.viewModel?.presentFacebookFirebaseLoginFrom(self!)
    }).disposed(by: disposeBag)
  }
}
