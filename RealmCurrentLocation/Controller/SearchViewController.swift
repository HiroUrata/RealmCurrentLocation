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
    
    let realmCRUDModel = RealmCRUDModel()
    
    var searchBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LayerFuncGroup.searchViewDesign(targetView: searchItemView, targetButton: searchButton, targetTableView: tableView)
      
        realmCRUDModel.allReadRealmDatas(targetView: self)
        
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func search(_ sender: UIButton) {
        
        
    }
    
  
}

extension SearchViewController:UITableViewDelegate{
    
    
}

extension SearchViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch searchBool{
        
        case true: return realmCRUDModel.searchRealmDatasResultArray.count
            
        case false: return realmCRUDModel.allReadRealmDatasResultArray.count
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    
}
