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
  typealias GoogleSignInArgs = (viewToPresent: UIViewController?, completion: GoogleSignInCompletion?)
  typealias GoogleSignInCompletion = ((GIDGoogleUser?, Error?) -> Void)
  
  typealias FirebaseSignInArgs = (authentication: GIDAuthentication?, completion: FirebaseSignInCompletion?)
  typealias FirebaseSignInCompletion = ((AuthDataResult?, Error?) -> Void)
  
  static let shared = GoogleLoginService()
  
  private var googleSignInArgs: GoogleSignInArgs = (nil, nil)
  private var firebaseSignInArgs: FirebaseSignInArgs = (nil, nil)
    
  let googleUserDisconnected = PublishSubject<(GIDGoogleUser, Error)>()
    
//  private override init() {
//    super.init()
//  }
  
  func handleApplicationDidFinishLaunchingWithOptions() {
    FirebaseApp.configure()
    GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
    GIDSignIn.sharedInstance()?.delegate = self
  }
  
  func handleApplicationOpenURL(_ url: URL) -> Bool {
    return GIDSignIn.sharedInstance().handle(url)
  }
  
  func handleSceneOpenURLContexts(_ URLContexts: Set<UIOpenURLContext>) {
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
    GIDSignIn.sharedInstance()?.presentingViewController = googleSignInArgs.viewToPresent
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

extension GoogleLoginService {
  func rxGoogleSignIn(from view: UIViewController) -> Observable<GIDGoogleUser> {
    return Observable<GIDGoogleUser>.create { [weak self] observer -> Disposable in
      self?.googleSignIn(from: view) { user, error in
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
  
  func rxFirebaseSignIn(authentication: GIDAuthentication) -> Observable<AuthDataResult> {
    return Observable<AuthDataResult>.create { [weak self] observer -> Disposable in
      self?.firebaseSignIn(authentication: authentication) { authResult, error in
        if let error = error {
          observer.onError(error)
          return
        }
        
        observer.onNext(authResult!)
        observer.onCompleted()
      }
      return Disposables.create()
    }
  }
}
