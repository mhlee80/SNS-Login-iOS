//
//  AppDelegate.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import SwiftyBeaver
import FBSDKCoreKit
import KakaoOpenSDK

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    log.addDestination(ConsoleDestination())

    log.info("")
    
    // Google Login
    GoogleLoginService.shared.handleApplication(application,
                                                didFinishLaunchingWithOptions: launchOptions)
    
    // Facebook Login
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    if #available(iOS 9, *) {
      window = UIWindow()
      window?.rootViewController = LoginScreenCoordinator.createModule() as? UIViewController
      window?.makeKeyAndVisible()
    }
    
    return true
  }
  
  @available(iOS 9.0, *)
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    log.info("")

    // google sign-in
    if GoogleLoginService.shared.handleApplication(application, open: url, options: options) {
      return true
    }

    // facebook login
    if ApplicationDelegate.shared.application(
      application,
      open: url,
      sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
      annotation: options[UIApplication.OpenURLOptionsKey.annotation]) {
      return true
    }

    // kakao login
    if KOSession.handleOpen(url) {
      return true
    }

    return false
  }

  @available(iOS 9.0, *)
  func applicationDidEnterBackground(_ application: UIApplication) {
    log.info("")
    KOSession.handleDidEnterBackground()
  }
  
  @available(iOS 9.0, *)
  func applicationDidBecomeActive(_ application: UIApplication) {
    log.info("")
    KOSession.handleDidBecomeActive()
  }
  
  // MARK: UISceneSession Lifecycle
  @available(iOS 13, *)
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  @available(iOS 13, *)
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
}
