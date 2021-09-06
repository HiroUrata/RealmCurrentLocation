//
//  TopViewController.swift
//  RealmCurrentLocation
//
//  Created by UrataHiroki on 2021/08/27.
//

import UIKit
import LocalAuthentication

class TopViewController: UIViewController, UIViewControllerTransitioningDelegate {

    
    @IBOutlet weak var topSystemIndigoView: UIView!
    @IBOutlet weak var beforeResultLabel: UILabel!
    @IBOutlet weak var beforeResultDateLabel: UILabel!
    @IBOutlet weak var beforeResultLocationLabel: UILabel!
    @IBOutlet weak var showSignUpViewButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LayerFuncGroup.topViewDesign(targetLabels: [beforeResultLabel,beforeResultDateLabel,beforeResultLocationLabel], targetView: topSystemIndigoView, targetButton: showSignUpViewButton)
        
        
        
    }

    @IBAction func showGetCurrentDatasView(_ sender: UIButton) {
        
        //FaceID
        let context = LAContext()
        var error: NSError? = nil

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error){

            let reason = "TouchID "
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success,error in

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
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        PresentationController(presentedViewController: presented, presenting: presenting)
        
    }
}

