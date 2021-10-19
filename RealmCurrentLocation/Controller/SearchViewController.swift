//
//  SearchViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/29.
//

import UIKit

class SearchViewController: UIViewController, UIViewControllerTransitioningDelegate  {

    @IBOutlet weak var searchItemView: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    
    let realmCRUDModel = RealmCRUDModel()
    
    var searchBool = false //画面が変わるたびにfalseにする
    
    override func viewDidLoad() {
        super.viewDidLoad()

        LayerFuncGroup.searchViewDesign(targetView: searchItemView, targetButton: searchButton)
        blurView.layer.cornerRadius = 20.0
        blurView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        blurView.layer.masksToBounds = true
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

            let deleteAction = UIContextualAction(style: .destructive, title: "") { action,_,_  in

                let alert = UIAlertController(title: "確認", message: "選択中のデータを削除しますか?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "削除", style: .destructive, handler: { _ in

                    self.realmCRUDModel.selectRealmDataDelete(selectContensNumber: indexPath.row, targetView: self)
                    self.realmCRUDModel.allReadRealmDatas(targetView: self)
                    tableView.deleteRows(at: [indexPath as IndexPath], with: .automatic)
                    tableView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)

            }

            let searchAction = UIContextualAction(style: .normal, title: "") { _, _, _ in
                
                //緯度と経度から検索してMapを表示させる。
                let cellTSRView = CellTapSearchResultView()
                cellTSRView.tapCellNumber = indexPath.row
                cellTSRView.modalPresentationStyle = .custom
                cellTSRView.transitioningDelegate = self
                self.present(cellTSRView, animated: true, completion: nil)
                
            
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
        
        cell.backgroundColor = .tertiarySystemGroupedBackground
        cell.layer.borderColor = UIColor.clear.cgColor
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

extension SearchViewController{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        PresentationController(presentedViewController: presented, presenting: presenting)
        
    }
}
