//
//  TabBarViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/27.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .tertiarySystemGroupedBackground
        tabBar.tintColor = .systemIndigo
        tabBar.unselectedItemTintColor = .systemGray
        
        tabBar.layer.cornerRadius = 25.0
        tabBar.layer.masksToBounds = true
        //tabBar.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMinXMinYCorner]
        
    }
    

   
}
