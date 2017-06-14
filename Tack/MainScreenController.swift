//
//  MainScreenController.swift
//  Tack
//
//  Created by Patrick Mucsi on 2/13/17.
//  Copyright © 2017 Patrick Mucsi. All rights reserved.
//

import UIKit

class MainScreenController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        self.tabBar.tintColor = UIColor(red:0.95, green:0.38, blue:0.38, alpha:1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
