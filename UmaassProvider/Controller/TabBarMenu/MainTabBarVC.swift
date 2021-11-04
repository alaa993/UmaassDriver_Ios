//
//  MainTabBarVC.swift
//  UmaassProvider
//
//  Created by Hesam on 7/2/1398 AP.
//  Copyright © 1398 Hesam. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setMessageLanguageData(&HomeTab, key: "home")
        tabBar.items?[0].title = HomeTab
        
        setMessageLanguageData(&appointmentTab, key: "Appointments")
        tabBar.items?[1].title = appointmentTab
        
        setMessageLanguageData(&fileReview, key: "File preview")
        tabBar.items?[2].title = fileReview
        
        setMessageLanguageData(&setting, key: "setting")
        tabBar.items?[3].title = setting
        
    }
}

var HomeTab = String()
var appointmentTab = String()
var fileReview = String()
var setting = String()
