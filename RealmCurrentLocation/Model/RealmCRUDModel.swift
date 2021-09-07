//
//  RealmCRUDModel.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/31.
//

import Foundation
import RealmSwift


class RealmCRUDModel{
    
    
    
}


extension RealmCRUDModel{
    
    static func createRealmCurrentDatas(createDate:String,createCurrentLocation:String,createLatitude:String,createLongitude:String,targetView:UIViewController){
        
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
