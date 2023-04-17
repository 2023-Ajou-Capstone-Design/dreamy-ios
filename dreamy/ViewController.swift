//
//  ViewController.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/24.
//

import UIKit
import KakaoSDKUser

class ViewController: UIViewController, MTMapViewDelegate {

 
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
      
    }


    @IBAction func logoutBtn(_ sender: Any) {   //로그아웃 버튼
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                
                // ✅ 로그아웃 시 메인으로 보냄
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }
}

