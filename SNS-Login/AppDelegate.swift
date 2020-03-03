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
  

  // AppDelegate.m #import <FBSDKCoreKit/FBSDKCoreKit.h> - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions { [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions]; // Add any custom logic here. return YES; } - (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options { BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey] ]; // Add any custom logic here. return handled; }
      
    
  @available(iOS 9.0, *)
  func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    let googleSignInHandled = GIDSignIn.sharedInstance().handle(url)
    
    let facebookSignInHandled = ApplicationDelegate.shared.application(
      application,
      open: url,
      sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
      annotation: options[UIApplication.OpenURLOptionsKey.annotation])
    
    return googleSignInHandled || facebookSignInHandled
  }
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
