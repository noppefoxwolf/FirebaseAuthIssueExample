//
//  ViewController.swift
//  FirebaseAuthIssueExample
//
//  Created by Tomoya Hirano on 2019/05/30.
//  Copyright © 2019 Tomoya Hirano. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let user = Auth.auth().currentUser {
      print("user exists. get id token.")
      user.getIDToken { (token, error) in
        if let error = error {
          print(dump(error))
//            - Error Domain=FIRAuthErrorDomain Code=17999 "An internal error has occurred, print and inspect the error details for more information." UserInfo={FIRAuthErrorUserInfoNameKey=ERROR_INTERNAL_ERROR, NSLocalizedDescription=An internal error has occurred, print and inspect the error details for more information., NSUnderlyingError=0x2804f6fa0 {Error Domain=FIRAuthInternalErrorDomain Code=3 "(null)" UserInfo={FIRAuthErrorUserInfoDeserializedResponseKey={
//              code = 400;
//              details =     (
//                {
//                  "@type" = "type.googleapis.com/google.rpc.Help";
//                  links =             (
//                    {
//                      description = "Google developers console";
//                      url = "https://console.developers.google.com";
//                    }
//                  );
//                }
//              );
//              message = "API key not valid. Please pass a valid API key.";
//              status = "INVALID_ARGUMENT";
//              }}}} #0
          preconditionFailure()
        }
        dump(token)
      }
    } else {
      print("user not exists. signin anonymously")
      Auth.auth().signInAnonymously { (result, error) in
        if let error = error {
          print(dump(error))
          preconditionFailure()
        }
        result?.user.getIDToken { (token, error) in
          if let error = error {
            print(dump(error))
            preconditionFailure()
          }
          dump(token)
        }
      }
    }
  }


}

