//
//  FriendSearchResult.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/1/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess

class FriendSearchResult: UITableViewCell {

    @IBOutlet weak var FriendImage: UIImageView!
    @IBOutlet weak var FriendShowname: UILabel!
    @IBOutlet weak var FriendUsername: UILabel!
    @IBOutlet weak var FriendButton: UIButton!
    
    
    var keychain: Keychain = Keychain(service: "com.tackapp")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func addFriend(_ sender: Any) {
        let token:String = try! keychain.get("token")!
        let headers: HTTPHeaders = ["Authorization": "Token \(token)"]
        
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/add_friend/\(FriendUsername.text!)", method: .post, headers: headers).responseJSON { response in
            
            self.FriendButton.setTitleColor(UIColor.lightGray, for: .normal)
            self.FriendButton.setTitle("Pending", for: .normal)
            self.FriendButton.isEnabled = false
            self.FriendButton.backgroundColor = UIColor.white
            
            if response.result.value != nil {
                //Display "sent message" or something
                
                
                
            }
            
        }
        
        
        
    }
    
}
