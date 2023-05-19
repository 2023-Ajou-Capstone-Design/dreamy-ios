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
        // Do any additional setup after loading the view.
        
      
    }

    @IBOutlet var cardView: UIView!
    @IBOutlet var cardText: UILabel!
    
    @IBAction func logoutBtn(_ sender: Any) {   //로그아웃 버튼
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                
                firstLoginFlag = true   //최초 로그인 true
                // ✅ 로그아웃 시 메인으로 보냄
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    @IBAction func chatBtn(_ sender: UIButton) {
        UserDefaultManager.displayName = "mo"   //임시
        Auth.auth().signInAnonymously()
//        self.present(ChannelVC(currentUser: Auth.auth().currentUser!), animated: true)
        self.navigationController?.pushViewController(ChannelVC(currentUser: Auth.auth().currentUser!), animated: true)
//        navigationController?.setViewControllers([ChannelVC()], animated: true)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if userInfo.string(forKey: "User_Type") == "01"{    //결식아동이면
            cardText.text = userInfo.string(forKey: "User_cardNumber")  //카드번호 보여주기
        }
        else{
            cardView.isHidden = true//푸드쉐어러면 G드림카드 뷰 숨기기
        }
    }
}

