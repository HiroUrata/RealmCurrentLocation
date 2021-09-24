//
//  SearchViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/29.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchItemView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LayerFuncGroup.searchViewDesign(targetView: searchItemView, targetButton: searchButton, targetTableView: tableView)
      
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        
    }
    
  
}
