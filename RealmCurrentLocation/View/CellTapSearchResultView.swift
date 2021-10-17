//
//  CellTapSearchResultView.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/10/16.
//

import UIKit
import MapKit

class CellTapSearchResultView: UIViewController {

    
    @IBOutlet weak var dateResultLabel: UILabel!
    @IBOutlet weak var MapView: MKMapView!
    @IBOutlet weak var resultTextView: UITextView!
    
    var tapCellNumber = Int()
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    let realmCRUDModel = RealmCRUDModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(tapCellNumber)
        realmCRUDModel.selectReadRealmData(selectNumber: tapCellNumber)
        print(realmCRUDModel.selectReadRealmDataResultArray)
        
        dateResultLabel.text = realmCRUDModel.selectReadRealmDataResultArray[0]["selectRealmDate"]
        dateResultLabel.layer.cornerRadius = 13.0
        dateResultLabel.layer.masksToBounds = true
        resultTextView.layer.cornerRadius = 13.0
        resultTextView.layer.masksToBounds = true
        
    }
    
    override func viewDidLayoutSubviews() {
     
        if !hasSetPointOrigin {
         
            hasSetPointOrigin = true
            pointOrigin = self.view.frame.origin
         
        }
    }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
     
        guard sender.translation(in: view).y >= 0 else { return }
        
        view.frame.origin = CGPoint(x: 0, y: self.pointOrigin!.y + sender.translation(in: view).y)
        
        if sender.state == .ended {
         
            if sender.velocity(in: view).y >= 1300 {
             
                self.dismiss(animated: true, completion: nil)
             
            }else{
               
                UIView.animate(withDuration: 0.3) {
                 
                    self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                 
                }
            }
        }
    }
}

extension CellTapSearchResultView{
    
    open func displayGetDatas(displayDate:String){
        
        
    }
}
