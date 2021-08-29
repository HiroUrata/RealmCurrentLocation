//
//  TopViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/27.
//

import UIKit

class TopViewController: UIViewController {

    
    @IBOutlet weak var topSystemIndigoView: UIView!
    @IBOutlet weak var beforeResultLabel: UILabel!
    @IBOutlet weak var beforeResultDateLabel: UILabel!
    @IBOutlet weak var beforeResultLocationLabel: UILabel!
    @IBOutlet weak var showSignUpViewButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LayerFuncGroup.topViewDesign(targetLabels: [beforeResultLabel,beforeResultDateLabel,beforeResultLocationLabel], targetView: topSystemIndigoView, targetButton: showSignUpViewButton)
        
        
        
    }

    

}

