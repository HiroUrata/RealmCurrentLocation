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
//        tableView.dataSource = self

    }
    
    @IBAction func search(_ sender: UIButton) {
        
        
        
    }
    
  
}

extension SearchViewController:UITableViewDelegate{
    
    
}

extension SearchViewController:UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var returnValue = Int()
        
        switch realmCRUDModel.searchRealmDatasResultArray.count >= 0{
        
        case true:
            returnValue = realmCRUDModel.searchRealmDatasResultArray.count
            
        case false:
            returnValue = realmCRUDModel.allReadRealmDatasResultArray.count
        }

        return returnValue
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }



}
