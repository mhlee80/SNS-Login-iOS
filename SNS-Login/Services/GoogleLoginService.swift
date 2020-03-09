//
//  GoogleLoginService.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/04.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
import RxSwift

class GoogleLoginService: NSObject {
  typealias LoginArgs = (presentingView: UIViewController?, completion: LoginCompletion?)
  typealias LoginCompletion = ((GIDGoogleUser?, Error?) -> Void)
    
  static let shared = GoogleLoginService()
  
  private var loginArgs: LoginArgs = (nil, nil)
    
  let userDisconnected = PublishSubject<(GIDGoogleUser, Error)>()
    
  private override init() {
    super.init()
  }
  
  func handleApplication(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    FirebaseApp.configure()
    GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance()?.delegate = self
  }
  
  func handleApplication(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }
  
  @available(iOS 13, *)
  func handleScene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let openURLContext = URLContexts.first {
      GIDSignIn.sharedInstance().handle(openURLContext.url)
    }
  }
  
  func login(from view: UIViewController, completion: LoginCompletion?) {
    loginArgs = (view, completion)
    handleLogin()
  }
    
  private func handleLogin() {
    GIDSignIn.sharedInstance()?.presentingViewController = loginArgs.presentingView
    GIDSignIn.sharedInstance()?.signIn()
  }
}

extension GoogleLoginService: GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    loginArgs.completion?(user, error)
    
    // clean up
    loginArgs = (nil, nil)
    GIDSignIn.sharedInstance()?.presentingViewController = nil
  }

  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    userDisconnected.onNext((user, error))
  }
}

extension Reactive where Base: GoogleLoginService {
  func login(from view: UIViewController) -> Observable<GIDGoogleUser> {
    return Observable<GIDGoogleUser>.create { observer -> Disposable in
      self.base.login(from: view) { user, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        observer.onNext(user!)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
