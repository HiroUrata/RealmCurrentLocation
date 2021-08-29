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
        
        targetView.layer.cornerRadius = 25.0
        targetView.layer.shadowOffset = CGSize(width: 10, height: 10)
        targetView.layer.shadowOpacity = 0.65
        targetView.layer.shadowRadius = 5
        
        targetButton.layer.cornerRadius = 20.0
        targetButton.layer.shadowOffset = CGSize(width: 10, height: 10)
        targetButton.layer.shadowOpacity = 0.65
        targetButton.layer.shadowRadius = 5
    }
}
