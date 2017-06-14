//
//  RequestSearch.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/6/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import AlamofireImage

class RequestSearch: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var request: Request!
    
    init(table: UITableView){
        request = Request(tableView: table)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return request.totalRequests()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FriendRequest = Bundle.main.loadNibNamed("FriendRequest", owner: nil, options: nil)?.first as! FriendRequest
        tableView.addSubview(cell)
        
        let tempImage: UIImageView = UIImageView()
        tempImage.af_setImage(withURL: URL(string: request!.getRequests()[indexPath.row].profilePic!)!)
        //cell.FriendImage.image = imageFilter.filter(tempImage)
        
        cell.FriendRequestImage.image = tempImage.image?.af_imageRoundedIntoCircle()
        cell.FriendRequestShowname.text = request!.getRequests()[indexPath.row].showname
        cell.FriendRequestUsername.text = request!.getRequests()[indexPath.row].username
        cell.setId(newId: request!.getRequests()[indexPath.row].id!)
        
        return cell
    }

    func loadRequests(){
        request.loadRequests()
    }
    
}
