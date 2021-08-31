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
    @objc dynamic var currentLocation = String()
    
}
