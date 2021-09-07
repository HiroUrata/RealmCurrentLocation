//
//  Alert.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/09/07.
//

import Foundation
import UIKit

class Alert{
    
    static func showErrorAlert(errorContents:String,targetView:UIViewController){
        
        let alert = UIAlertController(title: "ERROR", message: "\(errorContents)に失敗しました。", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        targetView.present(alert, animated: true, completion: nil)
        
    }
    
    
}


