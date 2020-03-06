//
//  GoogleLoginService+Firebase.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/06.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import UIKit
import GoogleSignIn
import Firebase
import RxSwift

extension GoogleLoginService {
  func firebaseSignIn(authentication: GIDAuthentication, completion: ((AuthDataResult?, Error?) -> Void)?) {
    let idToken = authentication.idToken
    let accessToken = authentication.accessToken
    let credential = GoogleAuthProvider.credential(withIDToken: idToken!, accessToken: accessToken!)
    Auth.auth().signIn(with: credential) { authResult, error in
      completion?(authResult, error)
    }
  }
}
