//
//  MyPageVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/21.
//

import UIKit
import KakaoSDKUser

class MyPageVC: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var myNickName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myNickName.text = userInfo.string(forKey: "User_AKA")

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        myNickName.text = userInfo.string(forKey: "User_AKA")
        
        if segue.identifier == "FoodSharingSegue" {
            if let foodSharingVC = segue.destination as? FoodSharingListVC {
                foodSharingVC.isFromMyPage = true
            }
        }
    }
    
    @IBAction func changeNickBtn(_ sender: UIButton) {//닉네임 변경 버튼
        print("닉네임 입력창 오픈")
        
        let nicknameAlert = UIAlertController(title: "닉네임 설정", message: nil, preferredStyle: .alert) // 닉네임 설정 알림창
        nicknameAlert.addTextField{ (nick) in
            nick.placeholder = "닉네임을 설정해주세요"
        }
        
        let okayAction = UIAlertAction(title: "등록하기", style: .default) { action in  //등록하기 버튼 클릭시 액션
            if let nickTextField = nicknameAlert.textFields?.first{
                userInfo.set(nickTextField.text, forKey: "User_AKA")
                changeNickName(nickname: userInfo.string(forKey: "User_AKA")!){
                    self.myNickName.text = userInfo.string(forKey: "User_AKA")
                    self.myNickName.layoutIfNeeded()
                }
                self.dismiss(animated: false)

            }
        }   //end of registerAction
        
        nicknameAlert.addAction(okayAction)
        present(nicknameAlert, animated: false, completion: nil)
        
    }
    @IBAction func mySharingBtn(_ sender: UIButton) {// 내가 쓴글 확인하기 버튼
        
    }
    @IBAction func changeTown(_ sender: UIButton) {//탈퇴하기 버튼
        
    }
    @IBAction func logoutBtn(_ sender: UIButton) {//로그아웃 버튼
        UserApi.shared.unlink {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                
                firstLoginFlag = true   //최초 로그인 true
                // ✅ 로그아웃 시 메인으로 보냄
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
}
