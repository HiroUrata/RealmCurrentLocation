//
//  HalfViewProgram.swift
//  createHalfView
//
//  Created by UrataHiroki on 2021/07/02.
//


import UIKit
import MapKit

class GetCurrentLocationView:UIViewController{
        
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var getCurrentDatasButton: UIButton!
 
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    let clLocationManager = CLLocationManager()
    let mkPointAnnotation = MKPointAnnotation()
       
    
    override func viewDidLoad() {
           super.viewDidLoad()
                
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
     
        currentDateLabel.layer.cornerRadius = 13.0
        currentDateLabel.layer.masksToBounds = true
        currentLocationLabel.layer.cornerRadius = 13.0
        currentLocationLabel.layer.masksToBounds = true
        
        getCurrentDatasButton.layer.cornerRadius = 20.0
        getCurrentDatasButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        getCurrentDatasButton.layer.shadowColor = UIColor.black.cgColor
        getCurrentDatasButton.layer.shadowOpacity = 0.7
        getCurrentDatasButton.layer.shadowRadius = 8
        
        showPermission()
        setUpLocationManager()
       }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
        
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
    
    @IBAction func getCurrentDatas(_ sender: UIButton) {
        

    
    }
    
}


//位置情報関連
extension GetCurrentLocationView:MKMapViewDelegate,CLLocationManagerDelegate, UIGestureRecognizerDelegate{
    
    //位置情報の取得を許可するか表示
    func showPermission(){ //viewが表示された時に使用

        clLocationManager.delegate = self
        mapView.delegate = self
        
        clLocationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        clLocationManager.requestWhenInUseAuthorization()
        clLocationManager.startUpdatingLocation() //位置情報を取得を許可するか表示
        mapView.mapType = .standard //標準の地図を表示
        mapView.userTrackingMode = .follow
    }
    
    func setUpLocationManager(){

        clLocationManager.requestAlwaysAuthorization()

        if CLAccuracyAuthorization.fullAccuracy == .fullAccuracy{

            self.clLocationManager.startUpdatingLocation() //現在地の取得を開始
        }
        
    }

    //使用者の現在地の緯度と経度を取得して、住所か建物の名前などに変換
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!)) { placeMark, error in
            
            if error != nil{
                
                return
            }
            
            if let resultPlaceMark = placeMark?.first{
                
                if resultPlaceMark.administrativeArea != nil || resultPlaceMark.locality != nil{
                    
                    self.currentLocationLabel.text = "緯度[\((locations.first?.coordinate.latitude)!)] 経度[\((locations.first?.coordinate.longitude)!)] 場所[\(resultPlaceMark.name! + resultPlaceMark.administrativeArea! + resultPlaceMark.locality!)]"
                    
                }else{
                    
                    self.currentLocationLabel.text = resultPlaceMark.name!
                }
            }
        }
    }
    
    
}



