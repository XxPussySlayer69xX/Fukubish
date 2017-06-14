//
//  Groups.swift
//  Tack
//
//  Created by Patrick Mucsi on 3/19/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import Foundation
import UIKit

class Groups: NSObject, UITableViewDataSource, UITableViewDelegate{
    
    let sectionSpacing: CGFloat = 5
    let cellIdentifier: String = "BoardIdentifier"
    
    var loader: GroupLoader!
    
    init(table: UITableView){
        self.loader = GroupLoader(tableview: table)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.loader.totalGroups()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionSpacing
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CustomBoard = Bundle.main.loadNibNamed("CustomBoard", owner: nil, options: nil)?.first as! CustomBoard
        tableView.addSubview(cell)
        
        cell.BoardName.text = self.loader.getGroups()[indexPath.section].groupName
        
                //New way of loading images - Uses Alamofire to load in images with more customization options
        let tempImage: UIImageView = UIImageView()
        tempImage.af_setImage(withURL: URL(string: self.loader.getGroups()[indexPath.row].groupImage!)!)
        cell.BoardImage.image = tempImage.image
                //Old way of loading images - Uses SwiftGifOrigin which was too slow for loading actual images
        //cell.BoardImage.image = UIImage.gif(url: self.loader.getGroups()[indexPath.section].groupImage!)
        
//        cell.backgroundColor = UIColor
        
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Deselects selected tableviewcell
        tableView.deselectRow(at: indexPath, animated: true)
        
        //Load Group into current View
        
    }
}
