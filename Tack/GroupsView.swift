//
//  GroupsView.swift
//  Tack
//
//  Created by Patrick Mucsi on 2/4/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import Alamofire
import KeychainAccess

class GroupsView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var GroupsDataSource: Groups!
    private var GroupCreator: CreateGroup!
    private var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_sender: )), for: UIControlEvents.valueChanged)
        tableView.addSubview(refreshControl)
        
        self.GroupsDataSource = Groups(table: tableView)
        //self.GroupCreator = CreateGroup(parentView: self.view, visualEffect: visualEffectView)
        
        self.tableView.dataSource = self.GroupsDataSource
        self.tableView.delegate = self.GroupsDataSource
        self.tableView.separatorStyle = .none
        self.tableView.tableFooterView = UIView()
    }
    
    func checkFormValid(){
//        Alamofire.request("url to check if form is valid", /*headers:headers,*/ method:.post).responseJSON { response in
//         
//            let valueReturned:NSDictionary = response.result.value as! NSDictionary
//            for(key, value) in valueReturned{
//                print("\(key) -> \(value)")
//            }
//        }
        
    }
    
    
    func refresh(_sender:AnyObject){
        self.GroupsDataSource.loader.loadGroups()
        refreshControl.endRefreshing()
    }
    
    @IBAction func showCreateGroup(_ sender: Any) {
        GroupCreator.animateIn()
    }
    
    
}
