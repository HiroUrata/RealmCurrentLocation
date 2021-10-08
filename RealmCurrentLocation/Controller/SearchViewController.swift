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
    @IBOutlet weak var reloadButton: UIButton!
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
        realmCRUDModel.allReadRealmDatas(targetView: self)
        tableView.reloadData()
    }
    
    @IBAction func search(_ sender: UIButton) {
        //検索が完了したらsearchBoolをtrueにする
        if locationTextField.text!.isEmpty && dateTextField.text!.isEmpty == false{
        
        realmCRUDModel.searchReadRealmData(searchLocation: locationTextField.text!, searchDay: dateTextField.text!, targetView: self)
        searchBool = true
        tableView.reloadData()
        }else{
            
            searchBool = false
            realmCRUDModel.allReadRealmDatas(targetView: self)
            tableView.reloadData()
        }
    }
    
    @IBAction func reload(_ sender: UIButton) {
        
        if searchBool == false{
            
            realmCRUDModel.allReadRealmDatas(targetView: self)
            tableView.reloadData()
        }else if searchBool == true{
            
            realmCRUDModel.searchReadRealmData(searchLocation: locationTextField.text!, searchDay: dateTextField.text!, targetView: self)
            tableView.reloadData()
        }
        
    }
    
  
}

extension SearchViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if searchBool == false{
            
            let deleteAction = UIContextualAction(style: .destructive, title: "") { _,_,_  in
                
                
            }
            
            let searchAction = UIContextualAction(style: .normal, title: "") { _, _, _ in
                
            }
            
            deleteAction.image = UIImage(systemName: "trash")
            searchAction.image = UIImage(systemName: "magnifyingglass")
            searchAction.backgroundColor = .systemGreen
            
            return UISwipeActionsConfiguration(actions: [deleteAction,searchAction])
        }else{
            
            return nil
        }
        
        
    }
    
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
        
        cell.layer.cornerRadius = 20.0
        cell.layer.borderColor = UIColor.systemIndigo.cgColor
        cell.layer.borderWidth = 5.0
        
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


extension SearchViewController:UITabBarControllerDelegate{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedIndex == 1{
            
            tableView.reloadData()
        }
    }
}
