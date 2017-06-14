//
//  FriendRequest.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/5/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess

class FriendRequest: UITableViewCell {

    @IBOutlet weak var FriendRequestImage: UIImageView!
    @IBOutlet weak var FriendRequestShowname: UILabel!
    @IBOutlet weak var FriendRequestUsername: UILabel!
    @IBOutlet weak var RequestResult: UILabel!
    @IBOutlet weak var AcceptButton: UIButton!
    @IBOutlet weak var DenyButton: UIButton!
    
    private var headers: HTTPHeaders = [:]
    private var keychain: Keychain = Keychain(service: "com.tackapp")
    private var id: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let token = try! keychain.get("token")!
        headers = ["Authorization": "Token \(token)"]
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setId(newId: Int){
        self.id = newId
    }
    
    @IBAction func acceptRequest(_ sender: Any) {
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/accept_friend/\(self.id!)", method: .get, headers:headers).responseJSON {response in
            self.AcceptButton.isHidden = true
            self.DenyButton.isHidden = true
            self.RequestResult.text = "You accepted the request"
            self.RequestResult.isHidden = false
            
        }
        
    }
    
    @IBAction func denyRequest(_ sender: Any) {
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/deny_friend/\(self.id!)", method: .get, headers:headers).responseJSON {response in
            
            self.AcceptButton.isHidden = true
            self.DenyButton.isHidden = true
            self.RequestResult.text = "You denied the request"
            self.RequestResult.isHidden = false
        }
    }
    
}
