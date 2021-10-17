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
    @IBOutlet weak var currentLocationTextView: UITextView!
    @IBOutlet weak var registerButton: UIButton!
    
    var hasSetPointOrigin = false
    var pointOrigin: CGPoint?
    
    let clLocationManager = CLLocationManager()
    let mkPointAnnotation = MKPointAnnotation()
    let realmCRUDModel = RealmCRUDModel()
    
    var createContentsArray:[[String:String]] = []
    
    override func viewDidLoad() {
           super.viewDidLoad()
                
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
        view.addGestureRecognizer(panGesture)
     
        currentDateLabel.layer.cornerRadius = 13.0
        currentDateLabel.layer.masksToBounds = true
        currentLocationTextView.layer.cornerRadius = 13.0
        currentLocationTextView.layer.masksToBounds = true
        
        currentDateLabel.text = {() -> String in
            
            let formatter = DateFormatter()
            formatter.dateStyle = .full
            formatter.timeStyle = .medium
            formatter.locale = Locale(identifier: "ja_JP")
            let date = Date()
            return formatter.string(from:  date)
        }()
        
        registerButton.layer.cornerRadius = 20.0
        
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
    
    @IBAction func CurrentDataRegister(_ sender: UIButton) {
         
        realmCRUDModel.createRealmCurrentDatas(createDate: createContentsArray[0]["createDate"]!,
                                               createDay: {() -> String in
                                                
                                                let formatter = DateFormatter()
                                                formatter.dateStyle = .long
                                                formatter.timeStyle = .none
                                                formatter.locale = Locale(identifier: "ja_JP")
                                                let date = Date()
                                                print(formatter.string(from:  date))
                                                return formatter.string(from:  date)
                                            }(),
                                               createCurrentLocation: createContentsArray[0]["createCurrentLocation"]!,
                                               createLatitude: createContentsArray[0]["createLatitude"]!,
                                               createLongitude: createContentsArray[0]["createLongitude"]!, targetView: self)
        
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
        mapView.showsCompass = true
        mapView.setUserTrackingMode(.followWithHeading, animated: true)
        mapView.isRotateEnabled = false
    }
    
    func setUpLocationManager(){

        clLocationManager.requestAlwaysAuthorization()

        if CLAccuracyAuthorization.fullAccuracy == .fullAccuracy{

            self.clLocationManager.startUpdatingLocation() //現在地の取得を開始
        }
        
    }

    //使用者の現在地の緯度と経度を取得して、住所か建物の名前などに変換
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        mapView.userTrackingMode = .followWithHeading
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: (locations.first?.coordinate.latitude)!, longitude: (locations.first?.coordinate.longitude)!)) { placeMark, error in
            
            if error != nil{ return }
            
            if let resultPlaceMark = placeMark?.first{
                
                self.createContentsArray = []
                
                self.createContentsArray.append(["createDate":self.currentDateLabel.text!,
                                                 "createCurrentLocation":resultPlaceMark.administrativeArea! + resultPlaceMark.subLocality! + resultPlaceMark.name!,
                                                 "createLatitude":String((locations.first?.coordinate.latitude)!),
                                                 "createLongitude":String((locations.first?.coordinate.longitude)!)])
                
                    self.currentLocationTextView.text = """
                        緯度
                        [\((locations.first?.coordinate.latitude)!)]
                        
                        経度
                        [\((locations.first?.coordinate.longitude)!)]
                        
                        場所
                        [\(resultPlaceMark.administrativeArea!)]
                        [\(resultPlaceMark.subLocality!)]
                        [\(resultPlaceMark.name!)]
                        """
                
            }
        }
    }
    
    

}



