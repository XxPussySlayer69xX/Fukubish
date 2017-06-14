//
//  UserSearch.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/5/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import AlamofireImage

class UserSearch: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var search: Search!
    
    init(table: UITableView){
        search = Search(tableView: table, searchLink: "", searchText: "")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return search.totalUsers()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendSearchResult = Bundle.main.loadNibNamed("FriendSearchResult", owner: nil, options: nil)?.first as! FriendSearchResult
        tableView.addSubview(cell)
        
        let tempImage: UIImageView = UIImageView()
        tempImage.af_setImage(withURL: URL(string: search!.getUsers()[indexPath.row].profilePic!)!)
        //cell.FriendImage.image = imageFilter.filter(tempImage)
        
        
        cell.FriendImage.image = tempImage.image?.af_imageRoundedIntoCircle()
        cell.FriendUsername.text = search!.getUsers()[indexPath.row].username!
        cell.FriendShowname.text = search!.getUsers()[indexPath.row].showname!
        
        if search!.getUsers()[indexPath.row].pendingRequest! {
            cell.FriendButton.setTitleColor(UIColor.lightGray, for: .normal)
            cell.FriendButton.backgroundColor = UIColor.white
            cell.FriendButton.setTitle(search!.getUsers()[indexPath.row].relation!, for: .normal)
            if search!.getUsers()[indexPath.row].relation! == "Friends" {
                cell.FriendButton.isHidden = true
            }
            cell.FriendButton.isEnabled = false
        }
        
        return cell
    }
 
    
    func updateSearch(search: String){
        self.search!.updateSearch(searchQuery: search)
    }

}
