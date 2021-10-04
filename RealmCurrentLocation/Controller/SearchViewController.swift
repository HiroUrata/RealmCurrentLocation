//
//  SearchViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/29.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchItemView: UIView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let realmCRUDModel = RealmCRUDModel()
    
    var searchBool = false //画面が変わるたびにfalseにする
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LayerFuncGroup.searchViewDesign(targetView: searchItemView, targetButton: searchButton, targetTableView: tableView)
      
        realmCRUDModel.allReadRealmDatas(targetView: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchBool = false
    }
    
    @IBAction func search(_ sender: UIButton) {
        //検索が完了したらsearchBoolをtrueにする
        if locationTextField.text!.isEmpty && dateTextField.text!.isEmpty == false{
        
        realmCRUDModel.searchReadRealmData(searchLocation: locationTextField.text!, searchDate: dateTextField.text!, targetView: self)
        searchBool = true
        tableView.reloadData()
        }
    }
    
  
}

extension SearchViewController:UITableViewDelegate{
    
    
}

extension SearchViewController:UITableViewDataSource{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.size.height / 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        var returnValue = Int()
        
        switch searchBool{
        
        case true:
            returnValue = realmCRUDModel.searchReadRealmDatasResultArray.count
            
        case false:
            returnValue = realmCRUDModel.allReadRealmDatasResultArray.count
        }

        return returnValue
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let cellDateLabel = cell.contentView.viewWithTag(1) as! UILabel
        let cellLocationLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        switch searchBool{
        
        case true:
            cellDateLabel.text = realmCRUDModel.searchReadRealmDatasResultArray[indexPath.row]["RealmSearchDate"]
            cellLocationLabel.text = realmCRUDModel.searchReadRealmDatasResultArray[indexPath.row]["RealmSearchLocation"]
            
        case false:
            cellDateLabel.text = realmCRUDModel.allReadRealmDatasResultArray[indexPath.row]["RealmDate"]
            cellLocationLabel.text = realmCRUDModel.allReadRealmDatasResultArray[indexPath.row]["RealmLocation"]
        }
 
        return cell
    }



}
