//
//  Search.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/5/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//


import Alamofire
import KeychainAccess

struct user{
    let profilePic: String?
    let showname: String?
    let username: String?
    let pendingRequest: Bool?
    let relation: String?
}

class Search {
    
    private var headers: HTTPHeaders = [:]
    private var keychain: Keychain = Keychain(service: "com.tackapp")
    private var token: String = ""
    private var table: UITableView!
    
    private var users = [user]()
    private let tempLink: String = "http://lh3.googleusercontent.com/mlXFpmF-VwyMezDK_Wt65DAElMKBO06YG35XY6hTaycR6uzk_e1qjKeC2hzUvovIVw8CJgRJhrnvtsnD1Oso"
    
    init(tableView table: UITableView, searchLink link: String, searchText text: String){
        self.table = table
        token = try! keychain.get("token")!
        headers = ["Authorization": "Token \(token)"]
        
    }
    
    public func updateSearch(searchQuery: String){
        
        self.users.removeAll()
        
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/search/\(searchQuery.lowercased())", method: .get, headers: self.headers).responseJSON{
            response in
            
            if response.result.value != nil{
                
                let jsonWrap = response.result.value as! NSDictionary
                self.unwrapJSON(JSON: jsonWrap)
                
                
            }
            self.table.reloadData()
        }
    }
    
    func unwrapJSON(JSON: NSDictionary){
        let json: NSDictionary = JSON.object(forKey: "data") as! NSDictionary
        var isRequestPending: Bool = false
        var relation: String = ""
        
        if let status:String = JSON.object(forKey: "message") as! String?{
            isRequestPending = true
            relation = status
        }
        let username: String = json.object(forKey: "username") as! String
        let showname: String = "showname"//json.object(forKey: "showname") as! String"
        let profilePicture: String = self.tempLink//json.object(forKey: "profilePicture") as! String
        
        self.createUser(username: username, showname: showname, profilePictureLink: profilePicture, pendingFriendRequest: isRequestPending, relation: relation)
    }
    
    
    func createUser(username: String, showname: String, profilePictureLink: String, pendingFriendRequest: Bool, relation: String){
        self.users.append(user(profilePic: profilePictureLink, showname: showname, username: username, pendingRequest: pendingFriendRequest, relation: relation))
    }
    
    func totalUsers() -> Int {
        return users.count
    }
    
    func getUsers() ->[user] {
        return self.users
    }
    
}
