//
//  ConsentStatementViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/10/05.
//

import UIKit

class ConsentStatementViewController: UIViewController {

    @IBOutlet weak var consentStatementView: UITextView!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    
    @IBAction func check(_ sender: UIButton) {
        
        if sender.currentBackgroundImage == UIImage(systemName: "stop"){
            
            sender.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }else if sender.currentBackgroundImage == UIImage(systemName: "checkmark.square"){
            
            sender.setBackgroundImage(UIImage(systemName: "stop"), for: .normal)
        }
        
    }
    
    
}
