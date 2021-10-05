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

        checkButton.tintColor = .black
        
        startButton.setTitle("注意事項を必ずお読み下さい", for: .normal)
        startButton.setTitleColor(.orange, for: .normal)
        startButton.titleLabel?.adjustsFontSizeToFitWidth = true
        startButton.layer.cornerRadius = 20.0
        startButton.isEnabled = false
        
        consentStatementView.isEditable = false
        consentStatementView.text = """
                                    注意事項
                                    1.このアプリは端末にデータを保存する様にプログラムをしています。よって、アプリを削除するなどの操作(保存済みのデータが削除されるその他の操作も同様）で保存済みのデータが同時に削除されます。データが削除されたことで生じた損害、トラブルについてアプリ製作者に一切の責任を問わない事に同意した事になります。
                                    
                                    2.このアプリは端末の位置情報を使用します。
                                    
                                    3.このアプリはFaceIDまたはTouchIDを使用します。
                                    
                                    4.このアプリを利用した者は、このアプリを利用した場合に生じた損害、トラブルについてアプリ製作者に一切の責任を問わない事に同意した事になります。
                                    
                                    5.このアプリは予告なく使用出来なくなる場合があります。アプリが使用出来なくなった事で生じた損害、トラブルについてアプリ製作者に一切の責任を問わない事に同意した事になります。
                                    
                                    6.いかなる場合も、アプリ製作者にこのアプリが関わった事で生じた、いかなる損害やトラブルについて一切の責任を問わない事に同意します。
                                    """
     
    }
    
    @IBAction func check(_ sender: UIButton) {
        
        if sender.currentBackgroundImage == UIImage(systemName: "stop"){
            
            sender.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            sender.tintColor = .systemGreen
            startButton.setTitle("AppStart", for: .normal)
            startButton.setTitleColor(.white, for: .normal)
            startButton.backgroundColor = .systemGreen
            startButton.isEnabled = true
            startButton.layer.masksToBounds = false
            startButton.layer.shadowOffset = CGSize(width: 5, height: 5)
            startButton.layer.shadowRadius = 5.0
            startButton.layer.shadowOpacity = 0.8
        }else if sender.currentBackgroundImage == UIImage(systemName: "checkmark.square"){
            
            sender.setBackgroundImage(UIImage(systemName: "stop"), for: .normal)
            sender.tintColor = .black
            startButton.setTitle("注意事項を必ずお読み下さい", for: .normal)
            startButton.setTitleColor(.orange, for: .normal)
            startButton.backgroundColor = .white
            startButton.titleLabel?.adjustsFontSizeToFitWidth = true
            startButton.isEnabled = false
            startButton.layer.masksToBounds = true
        }
        
    }
    
    @IBAction func appStart(_ sender: UIButton) {
        
        if checkButton.currentBackgroundImage == UIImage(systemName: "stop"){
            
            return
            
        }else if checkButton.currentBackgroundImage == UIImage(systemName: "checkmark.square"){
            
            UserDefaults.standard.set(true, forKey: "AgreeBool")
            
            let tabbarVC = storyboard?.instantiateViewController(identifier: "Tabbar") as! TabBarViewController
            tabbarVC.modalPresentationStyle = .fullScreen
            present(tabbarVC, animated: true, completion: nil)
            print("AppStart")
        }
    }
    
    
    
}
