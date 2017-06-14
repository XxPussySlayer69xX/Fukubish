//
//  ProfileView.swift
//  Tack
//
//  Created by Patrick Mucsi on 2/19/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import KeychainAccess

class ProfileView: UIViewController {
    
    var keychain: Keychain = Keychain(service: "com.tackapp")
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var ProfilePicture: UIImageView!
    
    let tempLink: String = "http://lh3.googleusercontent.com/mlXFpmF-VwyMezDK_Wt65DAElMKBO06YG35XY6hTaycR6uzk_e1qjKeC2hzUvovIVw8CJgRJhrnvtsnD1Oso"
    
    var ProfilePictureLink: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token:String = try! keychain.get("token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]
        
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/profile", method: .get, headers:headers).responseJSON { response in
            
            let jsonWrap: NSDictionary = response.result.value as! NSDictionary
            
            let json: NSDictionary = jsonWrap.object(forKey: "user") as! NSDictionary
            
            self.createProfile(username: json.object(forKey: "username") as! String, email: json.object(forKey: "email") as! String, profilePictureLink: self.tempLink)
        }
    }
    
    func createProfile(username: String, email:String, profilePictureLink: String) {
        DispatchQueue.main.async {
            self.username.text = username
            self.email.text = email
            self.ProfilePicture.af_setImage(withURL: URL(string: profilePictureLink)!)
        }
    }
    
    @IBAction func logOut(_ sender: Any) {
        
        do {
            try keychain.remove("token")
        }catch let error{
            print(error)
        }

        self.performSegue(withIdentifier: "GoToMain", sender: self)
    }
    
}
