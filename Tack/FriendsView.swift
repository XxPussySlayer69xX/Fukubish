//
//  FriendsView.swift
//  Tack
//
//  Created by Patrick Mucsi on 2/26/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import KeychainAccess

class FriendsView: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchResults: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    private var refreshControl: UIRefreshControl!
    private var searchDataSource: UserSearch?
    private var requestDataSource: RequestSearch?
    
    private var searchQuery:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull down to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_sender: )), for: UIControlEvents.valueChanged)
        
        searchResults.addSubview(refreshControl)
        
        searchDataSource = UserSearch(table: self.searchResults)
        requestDataSource = RequestSearch(table: self.searchResults)
        
        initializeCloseKeyboard()
        
        self.searchResults.tableFooterView = UIView()
        
        self.searchQuery = ""
        self.searchBar.delegate = self
        self.searchResults.delegate = searchDataSource
        self.searchResults.dataSource = searchDataSource
        
    }
    
    func refresh(_sender:AnyObject){
        switch segmentControl.selectedSegmentIndex {
        case 1:
            requestDataSource!.loadRequests()
            break
        case 0:
            searchDataSource!.updateSearch(search: getSearchQuery())
            break
        default:
            break
        }
        searchResults.reloadData()
        refreshControl.endRefreshing()
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            //switch delegate and datasource to search
            self.searchBar(self.searchBar, textDidChange: self.searchBar.text!)
            self.searchResults.delegate = searchDataSource
            self.searchResults.dataSource = searchDataSource
            break
        case 1:
            //switch delegate and datasource to friendRequests
            self.requestDataSource!.loadRequests()
            self.searchResults.delegate = requestDataSource
            self.searchResults.dataSource = requestDataSource
            break
        default:
            break
        }
        
        self.searchResults.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if segmentControl.selectedSegmentIndex == 0 {
            self.setSeachQuery(newSearchQuery: searchText)
            self.searchDataSource!.updateSearch(search: self.getSearchQuery())
        }
    }
    
    public func getSearchQuery() -> String {
        return self.searchQuery!
    }
    
    public func setSeachQuery(newSearchQuery query: String){
        searchQuery = query
    }
    
    func initializeCloseKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(FriendsView.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
}
