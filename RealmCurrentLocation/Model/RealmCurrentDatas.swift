//
//  RealmCurrentDatas.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/31.
//

import Foundation
import RealmSwift


class RealmCurrentDatas:Object{
    
    @objc dynamic var currentDate = String()
    @objc dynamic var currentDay = String() //検索機能で使用
    @objc dynamic var currentLocation = String()
    @objc dynamic var currentLatitude = String()  //緯度
    @objc dynamic var currentLongitude = String()  //経度
    
}
