//
//  FacebookLoginService+Firebase.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/06.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import Firebase

extension FacebookLoginService {
  func firebaseSignIn(accessToken: AccessToken, completion: ((AuthDataResult?, Error?) -> Void)?) {
    let token = accessToken.tokenString
    let credential = FacebookAuthProvider.credential(withAccessToken: token)
    Auth.auth().signIn(with: credential) { authResult, error in
      completion?(authResult, error)
    }
  }
}
