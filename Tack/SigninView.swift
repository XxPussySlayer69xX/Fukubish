//
//  signin_view.swift
//  Tack
//
//  Created by Patrick Mucsi on 1/30/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess

class SigninView: UIViewController {
    
    @IBOutlet weak var signin_Label: UILabel!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var keychain: Keychain = Keychain(service: "com.tackapp")
    
    let alert = UIAlertController(title: "Log in information not valid", message: "Please try again", preferredStyle: UIAlertControllerStyle.alert)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeTapGesture()
        initializeCloseKeyboard()
        
        alert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: nil))
        
    }
    
    //Allows user to tap on "sign up" to go to SignupView"
    func initializeTapGesture(){
        let signInTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninView.tapFunction))
        signin_Label.isUserInteractionEnabled = true
        signin_Label.addGestureRecognizer(signInTap)
    }
    
    //Allows user to tap outside of keyboard to close it
    func initializeCloseKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SigninView.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func tapFunction(sender:UITapGestureRecognizer){
        //Take to sign in page
        self.performSegue(withIdentifier: "switchToSignup", sender: self)
        
    }
    
    @IBAction func logIn(_ sender: Any) {
        let user = usernameField.text
        let password = passwordField.text
        
        let parameters: Parameters = ["username": user!, "password": password!]
        
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/signin", method: .post, parameters: parameters).responseJSON { response in
            
            let json: NSDictionary = response.result.value as! NSDictionary
            
            if let answer = json.object(forKey: "token") {
                self.keychain["token"] = answer as? String
                self.performSegue(withIdentifier: "LoggedIn", sender: self)
            }else{
                self.present(self.alert, animated: true, completion: nil)
                self.dismissKeyboard()
            }
            
        }
    }
    
    
}
