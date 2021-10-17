//
//  TopViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/27.
//

import UIKit
import MapKit
import LocalAuthentication

class TopViewController: UIViewController, UIViewControllerTransitioningDelegate {

    
    @IBOutlet weak var topSystemIndigoView: UIView!
    @IBOutlet weak var beforeResultLabel: UILabel!
    @IBOutlet weak var beforeResultDateLabel: UILabel!
    @IBOutlet weak var beforeResultLocationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var showSignUpViewButton: UIButton!
    
    let realmCRUDModel = RealmCRUDModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LayerFuncGroup.topViewDesign(targetLabels: [beforeResultLabel,beforeResultDateLabel,beforeResultLocationLabel], targetView: topSystemIndigoView, targetButton: showSignUpViewButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        realmCRUDModel.allReadRealmDatas(targetView: self)
        
        if realmCRUDModel.allReadRealmDatasResultArray.count > 0{

            beforeResultDateLabel.text = realmCRUDModel.allReadRealmDatasResultArray.last!["RealmDate"]
            beforeResultLocationLabel.text = realmCRUDModel.allReadRealmDatasResultArray.last!["RealmLocation"]
            
            indicateMap(cordinateLat: Double(realmCRUDModel.allReadRealmDatasResultArray.last!["RealmLatitude"]!), cordinateLog:  Double(realmCRUDModel.allReadRealmDatasResultArray.last!["RealmLongitude"]!))
        }
       
    }
    
    @IBAction func showGetCurrentDatasView(_ sender: UIButton) {
        
        //FaceID
        let context = LAContext()
        var error: NSError? = nil

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "TouchID ") { success,error in

                DispatchQueue.main.async {

                    guard success, error == nil else{
                        //認証失敗

                        print("失敗")

                        return
                    }

                    //認証成功時
                    let gCLView = GetCurrentLocationView()
                    gCLView.modalPresentationStyle = .custom
                    gCLView.transitioningDelegate = self
                    self.present(gCLView, animated: true, completion: nil)
                    

                }
            }
        }
    }

}

extension TopViewController{
    
    func indicateMap(cordinateLat:Double?,cordinateLog:Double?){
        
        guard let lat = cordinateLat else { print("not get lat"); return }
        guard let log = cordinateLog else { print("not get log"); return }
        
        let locationCordinate = CLLocationCoordinate2DMake(lat, log)
        
        let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        
        let coordinateRegion = MKCoordinateRegion(center: locationCordinate, span: mapSpan)
        
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension TopViewController{
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        PresentationController(presentedViewController: presented, presenting: presenting)
        
    }
}

