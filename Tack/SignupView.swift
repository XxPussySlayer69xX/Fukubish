//
//  ViewController.swift
//  Tack
//
//  Created by Patrick Mucsi on 1/25/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit

import Alamofire
import KeychainAccess

class SignupView: UIViewController {

    @IBOutlet weak var sign_inLabel: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var keychain: Keychain = Keychain(service: "com.tackapp")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*Setting Tap Gestures*/
        
        //Tap for closing down keyboard by tapping outside of keyboard
        initializeCloseKeyboard()
        //Tap for switching to log in
        initializeTapGesture()
        
        
    }
    
    func initializeTapGesture(){
        let signInTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupView.tapFunction))
        sign_inLabel.isUserInteractionEnabled = true
        sign_inLabel.addGestureRecognizer(signInTap)
    }
    
    func initializeCloseKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignupView.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sign_upButton(_ sender: Any) {
        
        let user = usernameField.text?.lowercased()
        let password = passwordField.text
        let email = emailField.text
        
        let parameters: Parameters = ["email": email!, "username": user!, "password": password!]
        
        
        
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/signup", method: .post, parameters: parameters).responseJSON { response in
            
            if response.result.value != nil {
                self.keychain["token"] = response.result.value as! String?
                self.performSegue(withIdentifier: "SignedUp", sender: self)
            }
            
        }
        
        
        
    }
    
    func checkUsernameAvailable(username: String){
        let parameters: Parameters = ["username": username]
        Alamofire.request("check available", parameters: parameters).response { response in
         
            
            
            
        }
    }

    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func tapFunction(sender:UITapGestureRecognizer){
        
        //Take to sign in page
        self.performSegue(withIdentifier: "switchToSignin", sender: self)
        
    }

}

