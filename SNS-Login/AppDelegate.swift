//
//  AppDelegate.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/02.
//  Copyright © 2020 mhlee. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import KakaoOpenSDK

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    log.addDestination(ConsoleDestination())
    
    // Google Login
    FirebaseApp.configure()
    GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance()?.delegate = self
    
    // Facebook Login
    ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    
    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
//  @available(iOS 9.0, *)
//  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//    log.info("")
//
//    // google sign-in handle
//    if GIDSignIn.sharedInstance().handle(url) {
//      return true
//    }
//
//    // facebook login handle
//    if ApplicationDelegate.shared.application(
//      application,
//      open: url,
//      sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
//      annotation: options[UIApplication.OpenURLOptionsKey.annotation]) {
//      return true
//    }
//
//    // kakao login handle
//    if KOSession.handleOpen(url) {
//      return true
//    }
//
//    return false
//  }

//  @available(iOS 9.0, *)
//  func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
//    // kakao login handle
//    log.info("")
//    if KOSession.handleOpen(url) {
//      return true
//    }
//
//    return false
//  }
  
//  func applicationDidEnterBackground(_ application: UIApplication) {
//    log.info("")
//    KOSession.handleDidEnterBackground()
//  }
  
//  func applicationDidBecomeActive(_ application: UIApplication) {
//    log.info("")
//    KOSession.handleDidBecomeActive()
//  }
}

extension AppDelegate: GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    if let error = error {
      log.info("error: \(error)")
      return
    }

    let userId = user.userID
    let idToken = user.authentication.idToken
    let fullName = user.profile.name
    let givenName = user.profile.givenName
    let familyName = user.profile.familyName
    let email = user.profile.email
    
    log.info("userId: \(userId ?? "nil")")
    log.info("idToken: \(idToken ?? "nil")")
    log.info("fullName: \(fullName ?? "nil")")
    log.info("givenName: \(givenName ?? "nil")")
    log.info("familyName: \(familyName ?? "nil")")
    log.info("email: \(email ?? "nil")")
    
    guard let authentication = user.authentication else { return }
    let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                      accessToken: authentication.accessToken)
    log.info("credential: \(credential)")
    
    // firebase 인증
    Auth.auth().signIn(with: credential) { (authResult, error) in
      if let error = error {
        log.info("error: \(error)")
        return
      }
    }
  }
  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    // Perform any operations when the user disconnects from app here.
    if let error = error {
      log.info("error: \(error))")
    }
  }
}
