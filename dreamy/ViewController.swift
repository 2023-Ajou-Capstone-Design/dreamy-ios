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
            var cardNum = userInfo.string(forKey: "User_cardNumber")
            var formattedNumber = ""
            
            for (index, character) in cardNum!.enumerated() {// - 를 넣어서 보여주기
                if index > 0 && index % 4 == 0 {
                    formattedNumber += "-"
                }
                formattedNumber += String(character)
            }
            cardText.text = formattedNumber
        }
        else{
            cardView.isHidden = true//푸드쉐어러면 G드림카드 뷰 숨기기
        }
        
    }

    @IBOutlet var cardView: UIView!
    @IBOutlet var cardText: UILabel!
    
    @IBAction func chatBtn(_ sender: UIButton) {
//        UserDefaultManager.displayName = "mo"   //임시
//        Auth.auth().signInAnonymously()

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
