//
//  LoginViewController.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/14.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

var myUser: userModel?  = nil  // DB로 보내줄 User정보
var firstLoginFlag : Bool = false   //최초 로그인 여부

class LoginViewController: UIViewController {   //로그인 뷰 컨트롤러
    
    @IBOutlet var loginWithKakaoImageView: UIButton!
    @IBOutlet var loginWithKakaoaccountImageView: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestureRecognizer()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name("TownregisterNotification"), object: nil)   //동네 설정이 완료됐단 알림 받기

    }
    
    @objc func handleNotification(_ notification: Notification) {   // 알림 핸들링 함수
            // Handle the notification and call getUserInfo
            getUserInfo()
        }
        
        deinit {
            NotificationCenter.default.removeObserver(self)
        }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ✅ 유효한 토큰 검사
        if (AuthApi.hasToken()) {
            UserApi.shared.accessTokenInfo { (_, error) in
                if let error = error {
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true  {
                        //로그인 필요
                    }
                    else {
                        //기타 에러
                    }
                }
                else {
                    //토큰 유효성 체크 성공(필요 시 토큰 갱신됨)
                    print("토큰 유효성 체크 성공")
                    // ✅ 사용자 정보를 가져오고 화면전환을 하는 커스텀 메서드
                    self.getUserInfo()
                }
            }
        }
        else {
            //로그인 필요
        }
    }
}

// MARK: - Extensions
extension LoginViewController {
    
    //        private func setUI() {
    //
    //            // ✅ 카카오 로그인 이미지 설정
    //            loginWithKakaoImageView.contentMode = .scaleAspectFit
    //            loginWithKakaoImageView.image = UIImage(named: "kakao_login_large_wide")
    //
    //            loginWithKakaoaccountImageView.contentMode = .scaleAspectFit
    //            loginWithKakaoaccountImageView.image = UIImage(named: "kakao_login_large_wide")
    //
    //            self.navigationController?.navigationBar.isHidden = true
    //        }
    
    // ✅ 이미지뷰에 제스쳐 추가
    private func setGestureRecognizer() {
        let loginKakao = UITapGestureRecognizer(target: self, action: #selector(loginKakao))
        loginWithKakaoImageView.isUserInteractionEnabled = true
        loginWithKakaoImageView.addGestureRecognizer(loginKakao)
        
        let loginKakaoAccount = UITapGestureRecognizer(target: self, action: #selector(loginKakaoAccount))
        loginWithKakaoaccountImageView.isUserInteractionEnabled = true
        loginWithKakaoaccountImageView.addGestureRecognizer(loginKakaoAccount)
    }
    
    private func getUserInfo() {
        // ✅ 사용자 정보 가져오기
        UserApi.shared.me() { [self](user, error) in
            if let error = error {
                print(error)
            }
            else {
                print("getUserInfo 함수 실행")
                
//                 ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
//                                    let nickname = user?.kakaoAccount?.profile?.nickname
                                    let email = user?.kakaoAccount?.email
                //
                //                    guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "LogoutViewController") as? LogoutViewController else { return }
                //
                // ✅ 사용자 정보 넘기기
                userInfo.set(email, forKey: "User_Email")   //카카오로 받은 Email을 userInfo에 추가
                
                guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") else { return }
                
                self.navigationController?.pushViewController(nextVC, animated: true)
                
                print(userInfo.string(forKey: "User_Email"), userInfo.string(forKey: "User_AKA"), userInfo.string(forKey: "User_cardNumber"), userInfo.string(forKey: "User_Town"), userInfo.string(forKey: "User_Type"))
                
                if firstLoginFlag == true{//자동 로그인이 아닌 최초 로그인이면
                    loginReqeust()  //로그인 리퀘스트
                    firstLoginFlag = false
                }
            }
        }
    }
    
    // MARK: - @objc Methods
    
    // ✅ 카카오로그인 이미지에 UITapGestureRecognizer 를 등록할 때 사용할 @objc 메서드.
    // ✅ 카카오톡으로 로그인
    @objc
    func loginKakao() {
        print("loginKakao() called.")
        
        // ✅ 카카오톡 설치 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    
                    // ✅ 회원가입 성공 시 oauthToken 저장
                    //                    let kakoOauthToken = oauthToken
                    //UserDefaults.standard.set(kakoOauthToken, forKey: "KakoOauthToken")
                    
                    // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
//                    self.getUserInfo()
                }
            }
        }
        // ✅ 카카오톡 미설치
        else {
            print("카카오톡 미설치")
        }
    }
    
    // ✅ 카카오로그인 이미지에 UITapGestureRecognizer 를 등록할 때 사용할 @objc 메서드.
    // ✅ 카카오계정으로 로그인
    @objc
    func loginKakaoAccount() {
        firstLoginFlag = true
        print("loginKakaoAccount() called.")
        
        // ✅ 기본 웹 브라우저를 사용하여 로그인 진행.
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                // ✅ 회원가입 성공 시 oauthToken 저장
                // _ = oauthToken
                                
                showHaveCard(vc: self)
                
                // ✅ 사용자정보를 성공적으로 가져오면 화면전환 한다.
//                self.getUserInfo()
            }
        }
    }
}

func showHaveCard(vc: UIViewController) {   //아동급식카드 여부 팝업창 띄우기
    print("급식카드 보유 팝업창 오픈")
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    guard let popupVC = storyboard.instantiateViewController(identifier: "haveCardVC") as? haveCardVC else { return }

    popupVC.modalPresentationStyle = .overCurrentContext
    
    vc.present(popupVC, animated: false)
    
}

func showTownRegister(vc: UIViewController) {   //아동급식카드 여부 팝업창 띄우기
    print("동네 설정 뷰 open")
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
    
    let popupVC = storyboard.instantiateViewController(identifier: "TownRegisterVC")
    
    popupVC.modalPresentationStyle = .overCurrentContext
    
    vc.present(popupVC, animated: false, completion: nil)
    
}
