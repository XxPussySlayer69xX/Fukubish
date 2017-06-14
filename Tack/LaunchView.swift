//
//  LaunchView.swift
//  Tack
//
//  Created by Patrick Mucsi on 2/21/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import KeychainAccess

class LaunchView: UIViewController {
 
    var keychain: Keychain = Keychain(service: "com.tackapp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let token:String! = try! keychain.getString("token")
        var id: String = ""
        
        if token != nil {
            id = "GoToLoggedIn"
        }else{
            id = "GoToMain"
        }
        
        self.performSegue(withIdentifier: id, sender: self)
    }
    
    
    
    
}
