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
        userInfo.set("01", forKey: "User_Type") // 유저타입 01
        
        let cardNumberAlert = UIAlertController(title: "카드 번호를 입력해 주세요.", message: nil, preferredStyle: .alert) // 카드번호등록 알림창
        cardNumberAlert.addTextField{ (cardNum) in
            cardNum.placeholder = "카드번호 16자리를 입력해주세요."
        }
        
        let registerAction = UIAlertAction(title: "등록하기", style: .default) { action in  //등록하기 버튼 클릭시 액션
            if let cardTextfield = cardNumberAlert.textFields?.first{
                if let cardNumber = cardTextfield.text, cardNumber.count == 16{//   입력한 숫자가 16자리면
                    myUser?.Card = cardTextfield.text
                    userInfo.set(cardTextfield.text, forKey: "User_cardNumber") //카드넘버 등록
                    
                    guard let pvc = self.presentingViewController else { return }//현재 vc
                    
                    self.dismiss(animated: false){//dismiss 후 바로 present
                        
                        showTownRegister(vc: pvc)
                    }
                }
                else{//16자리가 아니면 다시 입력하라는 알림
                    let retryNumber = UIAlertController(title: "16자리를 입력해주세요", message: nil, preferredStyle: .actionSheet)
                    self.present(retryNumber, animated: false)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { //1초 정도만 띄우기
                        retryNumber.dismiss(animated: true, completion: nil)
                    }
                }
            
            }
        }   //end of registerAction
        let cancleAction = UIAlertAction(title: "다음에 하기", style: .cancel){_ in  //다음에 하기 클릭시

            guard let pvc = self.presentingViewController else { return }//현재 vc
            
            self.dismiss(animated: true){
                showTownRegister(vc: pvc)
            }
        } // 다음에 하기 버튼 클릭시 액션
        
        cardNumberAlert.addAction(registerAction)//팝업창에 액션 추가
        cardNumberAlert.addAction(cancleAction)//팝업창에 액션 추가
        
        present(cardNumberAlert, animated: true, completion: nil)
    }//end of yesBtn
    
    @IBAction func noBtn(_ sender: UIButton) {  // 아니오 클릭시
        guard let pvc = self.presentingViewController else { return }//현재 vc

        myUser?.UserType = "99"
        userInfo.set("99", forKey: "User_Type") //유저타입 99 - 푸드쉐어러
        self.dismiss(animated: false){
            showTownRegister(vc: pvc)
        }

    }   // end of noBtn
    
    
}

