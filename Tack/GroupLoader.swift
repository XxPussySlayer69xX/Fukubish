//
//  GroupLoader.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/19/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import KeychainAccess
import Alamofire
import AlamofireImage

struct group{
    
    let groupName: String?
    let groupImage: String?
    let groupFirstColor: String?
    let groupSecondColor: String?
}

class GroupLoader {
    
    private var headers: HTTPHeaders = [:]
    private var keychain: Keychain = Keychain(service: "com.tackapp")
    private var token: String = ""
    
    private let tempLink: String = "http://lh3.googleusercontent.com/mlXFpmF-VwyMezDK_Wt65DAElMKBO06YG35XY6hTaycR6uzk_e1qjKeC2hzUvovIVw8CJgRJhrnvtsnD1Oso"
    
    var userGroups = [group]()
    
    private var table: UITableView!
    
    init(tableview: UITableView){
        
        self.token = try! keychain.get("token")!
        headers = ["Authorization": "Token \(token)"]
        self.table = tableview
        
        
        
        loadGroups()
    }
    
    func loadGroups(){
        self.userGroups.removeAll()
        Alamofire.request("http://tack-dev-env.vpr2nyirm8.us-west-2.elasticbeanstalk.com/app/groups", headers: headers).responseJSON { response in
            
            //if json is valid
            let JSON:NSArray = response.result.value as! NSArray
            print("result -> \(JSON)")
            //tokenize and put into userGroups array
//            self.addGroup(groupName: groupName, groupImage: groupImage, firstColor: groupColorOne, secondColor: groupColorTwo)
            
            //Reload table once groups load
            self.table.reloadData()
        }
    }
    
    func reloadGroups(){
        self.table.reloadData()
    }
    
    func getGroups()->[group]{
        return self.userGroups
    }
    
    func addGroup(groupName: String, groupImage: String, firstColor: String, secondColor: String){
        self.userGroups.append(group(groupName: groupName, groupImage: groupImage, groupFirstColor: firstColor, groupSecondColor: secondColor))
    }
    
    func totalGroups() -> Int {
        return self.userGroups.count
    }
    
}
