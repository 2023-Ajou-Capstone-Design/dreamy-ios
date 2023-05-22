//
//  ViewController.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/24.
//

import UIKit
import KakaoSDKUser
import FirebaseAuth

class ViewController: UIViewController, MTMapViewDelegate {

 
    override func viewDidLoad() {
        super.viewDidLoad()

        if userInfo.string(forKey: "User_Type") == "01"{    //결식아동이면
            cardText.text = userInfo.string(forKey: "User_cardNumber")  //카드번호 보여주기
        }
        else{
            cardView.isHidden = true//푸드쉐어러면 G드림카드 뷰 숨기기
        }
        
    }

    @IBOutlet var cardView: UIView!
    @IBOutlet var cardText: UILabel!
    
    @IBAction func chatBtn(_ sender: UIButton) {
        UserDefaultManager.displayName = "mo"   //임시
        Auth.auth().signInAnonymously()
//        self.present(ChannelVC(currentUser: Auth.auth().currentUser!), animated: true)
        self.navigationController?.pushViewController(ChannelVC(currentUser: Auth.auth().currentUser!), animated: true)
//        navigationController?.setViewControllers([ChannelVC()], animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "FoodSharingSegue" {
            if let foodSharingVC = segue.destination as? FoodSharingListVC {
                foodSharingVC.isFromMainPage = true
            }
        }
    }
    
    
    
}

