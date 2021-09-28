//
//  LayerFuncGroup.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/27.
//

import UIKit

class LayerFuncGroup{
    
    
    
}

extension LayerFuncGroup{
    
    static func topViewDesign(targetLabels:[UILabel],targetView:UIView,targetButton:UIButton){
        
        targetLabels.forEach({$0.layer.cornerRadius = 13.0; $0.layer.masksToBounds = true})
        
        targetView.layer.cornerRadius = 65.0
        targetView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        targetView.layer.shadowOffset = CGSize(width: 10, height: 10)
        targetView.layer.shadowOpacity = 0.65
        targetView.layer.shadowRadius = 5
        
        targetButton.layer.cornerRadius = 20.0
        targetButton.layer.shadowOffset = CGSize(width: 10, height: 10)
        targetButton.layer.shadowOpacity = 0.65
        targetButton.layer.shadowRadius = 5
    }
}


extension LayerFuncGroup{
    
    static func searchViewDesign(targetView:UIView,targetButton:UIButton,targetTableView:UITableView){
        
        targetView.layer.cornerRadius = 20.0
        targetView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        targetView.layer.shadowOffset = CGSize(width: 5, height: 5)
        targetView.layer.shadowOpacity = 0.7
        targetView.layer.shadowRadius = 5
        
        targetButton.layer.cornerRadius = 20.0
        
        targetTableView.layer.cornerRadius = 20.0
        targetTableView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        
    }
    
}
