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
  typealias GoogleSignInArgs = (presentingView: UIViewController?, completion: GoogleSignInCompletion?)
  typealias GoogleSignInCompletion = ((GIDGoogleUser?, Error?) -> Void)
  
  typealias FirebaseSignInArgs = (authentication: GIDAuthentication?, completion: FirebaseSignInCompletion?)
  typealias FirebaseSignInCompletion = ((AuthDataResult?, Error?) -> Void)
  
  static let shared = GoogleLoginService()
  
  private var googleSignInArgs: GoogleSignInArgs = (nil, nil)
  private var firebaseSignInArgs: FirebaseSignInArgs = (nil, nil)
    
  let googleUserDisconnected = PublishSubject<(GIDGoogleUser, Error)>()
    
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
  
  func googleSignIn(from view: UIViewController, completion: GoogleSignInCompletion?) {
    googleSignInArgs = (view, completion)
    handleGoogleSignIn()
  }
  
  func firebaseSignIn(authentication: GIDAuthentication, completion: FirebaseSignInCompletion?) {
    firebaseSignInArgs = (authentication, completion)
    handleFirebaseSignIn()
  }
  
  private func handleGoogleSignIn() {
    GIDSignIn.sharedInstance()?.presentingViewController = googleSignInArgs.presentingView
    GIDSignIn.sharedInstance()?.signIn()
  }
  
  private func handleFirebaseSignIn() {
    let idToken = firebaseSignInArgs.authentication!.idToken
    let accessToken = firebaseSignInArgs.authentication!.accessToken
    let credential = GoogleAuthProvider.credential(withIDToken: idToken!, accessToken: accessToken!)
    Auth.auth().signIn(with: credential) { [weak self] authResult, error in
      self?.firebaseSignInArgs.completion?(authResult, error)
      
      // clean up
      self?.firebaseSignInArgs = (nil, nil)
    }
  }
}

extension GoogleLoginService: GIDSignInDelegate {
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
    googleSignInArgs.completion?(user, error)
    
    // clean up
    googleSignInArgs = (nil, nil)
    GIDSignIn.sharedInstance()?.presentingViewController = nil
  }

  func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
    googleUserDisconnected.onNext((user, error))
  }
}
