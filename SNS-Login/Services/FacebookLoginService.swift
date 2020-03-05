//
//  FacebookLoginService.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class FacebookLoginService: NSObject {
  typealias LoginArgs = (presentingView: UIViewController?, permissions: [String], completion: LoginCompletion?)
  typealias LoginCompletion = ((LoginManagerLoginResult?, Error?) -> Void)
  
  static let shared = FacebookLoginService()
  
  private var loginArgs: LoginArgs = (nil, [], nil)
  
  private override init() {
    super.init()
  }
  
  func handleApplication(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
    ApplicationDelegate.shared.application(application,
                                           didFinishLaunchingWithOptions: launchOptions)
  }
  
  func handleApplication(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    return ApplicationDelegate.shared.application(application,
                                                  open: url,
                                                  sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                  annotation: options[UIApplication.OpenURLOptionsKey.annotation])
  }
  
  @available(iOS 13, *)
  func handleScene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
    if let openURLContext = URLContexts.first {
      ApplicationDelegate.shared.application(UIApplication.shared,
                                             open: openURLContext.url,
                                             sourceApplication: openURLContext.options.sourceApplication,
                                             annotation: openURLContext.options.annotation)
    }
  }
  
  func login(from view: UIViewController, permissions: [String], completion: LoginCompletion?) {
    loginArgs = (view, permissions, completion)
    handleLogin()
  }
  
  private func handleLogin() {
    let loginManager = LoginManager()
    loginManager.logIn(permissions: loginArgs.permissions, from: loginArgs.presentingView, handler: loginArgs.completion)
  }
}
