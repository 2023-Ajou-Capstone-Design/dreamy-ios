//
//  haveCardVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/07.
//

import UIKit

class haveCardVC: UIViewController {//아동급식카드여부 팝업창

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func yesBtn(_ sender: UIButton) { // 네 클릭시
        myUser?.UserType = "01"
        userInfo.set("01", forKey: "User_type")
        
        let cardNumberAlert = UIAlertController(title: "카드 번호를 입력해 주세요.", message: nil, preferredStyle: .alert) // 카드번호등록 알림창
        cardNumberAlert.addTextField{ (cardNum) in
            
        }
        
        let registerAction = UIAlertAction(title: "등록하기", style: .default) { action in  //등록하기 버튼 클릭시 액션
            if let cardTextfield = cardNumberAlert.textFields?.first{
                myUser?.Card = cardTextfield.text
                userInfo.set(cardTextfield.text, forKey: "User_cardNumber")
                                
                self.dismiss(animated: false)
                
//                showTownRegister(vc: self)
            }
        }
        let cancleAction = UIAlertAction(title: "다음에 하기", style: .cancel, handler: nil) // 다음에 하기 버튼 클릭시 액션
        
        cardNumberAlert.addAction(registerAction)//팝업창에 액션 추가
        cardNumberAlert.addAction(cancleAction)//팝업창에 액션 추가
        
        present(cardNumberAlert, animated: true, completion: nil)
    }
    
    @IBAction func noBtn(_ sender: UIButton) {  // 아니오 클릭시
        myUser?.UserType = "99"
        userInfo.set("99", forKey: "User_type")
        self.dismiss(animated: false)

    }
    
    
}

func showTownRegister(vc: UIViewController) {   //아동급식카드 여부 팝업창 띄우기
    print("동네 설정 뷰 open")
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    let popupVC = storyboard.instantiateViewController(identifier: "TownRegisterVC")
    
    popupVC.modalPresentationStyle = .overCurrentContext
    
    vc.dismiss(animated: false){
        vc.present(popupVC, animated: false, completion: nil)
    }
    
}
