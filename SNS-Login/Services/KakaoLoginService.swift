//
//  KakaoLoginService.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit
import KakaoOpenSDK
import RxSwift

class KakaoLoginService: NSObject {
  typealias LoginArgs = (presentingView: UIViewController?, completion: LoginCompletion?)
  typealias LoginResult = (token: KOToken, userMe: KOUserMe)
  typealias LoginCompletion = ((LoginResult?, Error?) -> Void)
  
  static let shared = KakaoLoginService()
  
  private var loginArgs: LoginArgs = (nil, nil)
  
  private override init() {
    super.init()
  }
  
  func handleApplication(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    // nothing to do
  }
  
  func handleApplication(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    return KOSession.handleOpen(url)
  }
  
  @available(iOS 9.0, *)
  func handleApplicationDidEnterBackground(_ application: UIApplication) {
    KOSession.handleDidEnterBackground()
  }
  
  @available(iOS 9.0, *)
  func handleApplicationDidBecomeActive(_ application: UIApplication) {
    KOSession.handleDidBecomeActive()
  }
  
  @available(iOS 13, *)
  func handleScene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let openURLContext = URLContexts.first {
      KOSession.handleOpen(openURLContext.url)
    }
  }
  
  func login(from view: UIViewController, completion: LoginCompletion?) {
    loginArgs = (view, completion)
    handleLogin()
  }
  
  private func handleLogin() {
    let session = KOSession.shared()!
    if session.isOpen() {
      session.close()
    }
    
    session.presentingViewController = loginArgs.presentingView
    session.open { [weak self] error in
      if let error = error {
        self?.loginArgs.completion?(nil, error)
        return
      }
      
      KOSessionTask.userMeTask { error, me in
        if let error = error {
          self?.loginArgs.completion?(nil, error)
          return
        }

        let result = LoginResult(session.token!, me!)
        self?.loginArgs.completion?(result, nil)
      }
    }
  }
}

extension Reactive where Base: KakaoLoginService {
  func login(from view: UIViewController) -> Observable<KakaoLoginService.LoginResult> {
    return Observable<KakaoLoginService.LoginResult>.create { observer -> Disposable in
      self.base.login(from: view) { result, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        observer.onNext(result!)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
