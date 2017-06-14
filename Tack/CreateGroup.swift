//
//  CreateGroup.swift
//  Tack
//
//  Created by Patrick Mucsi on 4/2/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import KeychainAccess
import Alamofire

class CreateGroup: UIView {
    
    private var parentView: UIView!
    private var visualEffect: UIVisualEffectView!
    private var effect:UIVisualEffect!

    private var headers: HTTPHeaders = [:]
    private var keychain: Keychain = Keychain(service: "com.tackapp")
    private var token: String = "";
    
    init(parentView: UIView, visualEffect: UIVisualEffectView){
        self.token = try! keychain.get("token")!
        headers = ["Authorization": "Token \(token)"]
        
        self.parentView = parentView
        self.visualEffect = visualEffect
        
        effect = visualEffect.effect
        visualEffect.effect = nil
        visualEffect.isUserInteractionEnabled = false
        //super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func animateIn(){
        self.layer.cornerRadius = 12
        createGestures()
        
        self.parentView.addSubview(self)
        self.center = self.parentView.center
        
        self.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.alpha = 0
        
        UIView.animate(withDuration: 0.4, animations: {
            //self.visualEffect.effect = self.effect
            self.visualEffect.isUserInteractionEnabled = true
            self.alpha = 1
            self.transform = CGAffineTransform.identity
        })
    }
    
    func createGestures(){
        createGestureRecognizer()
        initializeCloseKeyboard()
    }
    
    func initializeCloseKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateGroup.dismissKeyboard))
        self.addGestureRecognizer(tap)
    }
    
    func createGestureRecognizer(){
        let dismissCreateTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateGroup.dismissCreateGroup))
        visualEffect.addGestureRecognizer(dismissCreateTap)
    }
    
    func dismissCreateGroup(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.alpha = 0
            self.visualEffect.effect = nil
            self.visualEffect.isUserInteractionEnabled = false
        }){(success:Bool) in
            self.removeFromSuperview()
        }
    }
    
    func dismissKeyboard(){
        self.endEditing(true)
    }
    
    @IBAction func createGroup(_ sender: Any) {
        //Alamofire shit
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/create_group", headers: headers).responseJSON { response in
            
            
            
        }
    }
    
    
}
