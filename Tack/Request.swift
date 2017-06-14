//
//  Request.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/6/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import Alamofire
import KeychainAccess

struct request{
    let profilePic: String?
    let showname: String?
    let username: String?
    let id: Int?
}

class Request {
    
    private var headers: HTTPHeaders = [:]
    private var keychain: Keychain = Keychain(service: "com.tackapp")
    private var table: UITableView!

    private let tempLink:String = "http://lh3.googleusercontent.com/mlXFpmF-VwyMezDK_Wt65DAElMKBO06YG35XY6hTaycR6uzk_e1qjKeC2hzUvovIVw8CJgRJhrnvtsnD1Oso"
    private let tempShowname: String = "Test"
    
    private var requests = [request]()
    
    init(tableView table: UITableView){
        
        self.table = table
        let token = try! keychain.get("token")!
        headers = ["Authorization": "Token \(token)"]
    }
    
    func loadRequests(){
        self.requests.removeAll()
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/friend_requests", method: .get, headers:headers).responseJSON{ response in
         
            if response.result.value != nil{
                let allRequests: NSArray = response.result.value as! NSArray
                
                for singleRequest in allRequests {
                    print(singleRequest)
                    let jsonWrap:NSDictionary = singleRequest as! NSDictionary
                    let json: NSDictionary = jsonWrap.object(forKey: "from_user") as! NSDictionary
                    self.createUser(profilePitureLink: self.tempLink, username: json.object(forKey: "username") as! String, showname: self.tempShowname, id: jsonWrap.object(forKey: "id") as! Int)
                    
                }
                self.table.reloadData()
            }
            
            
        }
    }
    
    func removeRequest(id: Int){
        self.requests.remove(at: id)
        self.table.reloadData()
    }
    
    func createUser(profilePitureLink: String, username: String, showname: String, id: Int){
        self.requests.append(request(profilePic: profilePitureLink, showname: showname, username: username, id: id))
    }
    
    func totalRequests() ->Int {
        return requests.count
    }
    
    func getRequests() -> [request]{
        return self.requests
    }
    
}
