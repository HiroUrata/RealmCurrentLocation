//
//  RealmCRUDModel.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/31.
//

import Foundation
import RealmSwift


class RealmCRUDModel{
    
    var allReadRealmDatasResultArray:[[String:String]] = []
    var searchRealmDatasResultArray:[[String:String]] = []
    
    
}


extension RealmCRUDModel{
    
    func createRealmCurrentDatas(createDate:String,createCurrentLocation:String,createLatitude:String,createLongitude:String,targetView:UIViewController){
        
        do{
            let realm = try Realm()
            let realmCurrentDatas = RealmCurrentDatas()
            realmCurrentDatas.currentDate = createDate
            realmCurrentDatas.currentLocation = createCurrentLocation
            realmCurrentDatas.currentLatitude = createLatitude
            realmCurrentDatas.currentLongitude = createLongitude
            
            try realm.write({
                
                realm.add(realmCurrentDatas)
            })
        }catch{
            
            Alert.showErrorAlert(errorContents: "データの保存", targetView: targetView)
        }
        
        
    }
    
}


extension RealmCRUDModel{
    
    func allReadRealmDatas(targetView:UIViewController){
        
        do{
            let realm = try Realm()
            allReadRealmDatasResultArray = []
            
            realm.objects(RealmCurrentDatas.self).forEach { readResultData in
                
                self.allReadRealmDatasResultArray.append(["RealmDate":readResultData.currentDate,
                                                          "RealmLocation":readResultData.currentLocation,
                                                          "RealmLatitude":readResultData.currentLatitude,
                                                          "RealmLongitude":readResultData.currentLongitude])
            }
        }catch{
            
            Alert.showErrorAlert(errorContents: "データの取得", targetView: targetView)
        }
    }
    
}


extension RealmCRUDModel{
    
    func realmDataAllDelete(targetView:UIViewController){
        
        do {
            
            let realm = try Realm()
            
            try realm.write({
                
                realm.delete(realm.objects(RealmCurrentDatas.self))
                
            })
            
        }catch{
            
            Alert.showErrorAlert(errorContents: "データの削除", targetView: targetView)
        }
    }
}


extension RealmCRUDModel{
    
    func selectRealmDataDelete(selectContensNumber:Int,targetView:UIViewController){
        
        do{
            
            let realm = try Realm()
            
            try realm.write({
                
                realm.delete(realm.objects(RealmCurrentDatas.self)[selectContensNumber])
            })
        }catch{
            
            Alert.showErrorAlert(errorContents: "データの削除", targetView: targetView)

        }
    }
}
