//
//  KakaoLoginService+Rx.swift
//  SNS-Login
//
//  Created by mhlee on 2020/03/05.
//  Copyright © 2020 mhlee. All rights reserved.
//

import Foundation
import RxSwift
import KakaoOpenSDK

extension Reactive where Base: KakaoLoginService {
  func login(from view: UIViewController) -> Observable<KOToken> {
    return Observable<KOToken>.create { observer -> Disposable in
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
