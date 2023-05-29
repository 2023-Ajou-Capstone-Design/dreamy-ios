//
//  StoreDetailViewController.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/10.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    @IBOutlet var storeImage: UIImageView!
    @IBOutlet var storeName: UILabel!
    
    @IBOutlet var storeCategory: UILabel!
    @IBOutlet var storeOperatingTime: UILabel!  //운영시간
    @IBOutlet var storeAddress: UILabel!
    @IBOutlet var storePhoneNumber: UILabel!
    @IBOutlet var storeProvided1: UILabel!
    @IBOutlet var storeProvided2: UILabel!
    @IBOutlet var storeType: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(item: items[0])
        setupSheet()
        
        // Do any additional setup after loading the view.
    }
    
    private func setupSheet() {
        /// 밑으로 내려도 dismiss되지 않는 옵션 값
//        isModalInPresentation = true

        if let sheet = sheetPresentationController {
            /// 드래그를 멈추면 그 위치에 멈추는 지점: default는 large()
            sheet.detents = [.medium(), .large()]
            /// 초기화 드래그 위치
            sheet.selectedDetentIdentifier = .medium
            /// sheet아래에 위치하는 ViewController를 흐려지지 않게 하는 경계값 (medium 이상부터 흐려지도록 설정)
            sheet.largestUndimmedDetentIdentifier = .medium
            /// sheet로 present된 viewController내부를 scroll하면 sheet가 움직이지 않고 내부 컨텐츠를 스크롤되도록 설정
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            /// grabber바 보이도록 설정
            sheet.prefersGrabberVisible = true
            /// corner 값 설정
    //      sheet.preferredCornerRadius = 32.0
        }
    }
    
    @IBAction func bookMarkBtn(_ sender: UIButton) {    //북마크 추가 버튼
        bookMarkAdd {
            print("북마크 추가 완료")
            self.showToast("북마크 추가 완료", withDuration: 2.0, delay: 1.5)
        }
    }
    
    func showToast(_ message : String, withDuration: Double, delay: Double) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = UIColor.white
        toastLabel.font = UIFont.systemFont(ofSize: 14.0)
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 16
        toastLabel.clipsToBounds  =  true
            
        self.view.addSubview(toastLabel)
            
        UIView.animate(withDuration: withDuration, delay: delay, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
}

extension StoreDetailViewController{
    
   public func configure(item: StoreDB){
        
       if let storeName = self.storeName {
           storeName.text = item.StoreName
       }
       if let storeCategory = self.storeCategory {
           storeCategory.text = item.CateName
       }
       if let storeAddress = self.storeAddress {
           storeAddress.text = item.Address
       }
       if let storePhoneNumber = self.storePhoneNumber {
           storePhoneNumber.text = item.Phone
       }
       if let storeProvided1 = self.storeProvided1 {
           storeProvided1.text = item.Provided1
       }
       if let storeProvided2 = self.storeProvided2 {
           storeProvided2.text = item.Provided2
       }
       if let storeType = self.storeType {
           storeType.text = item.StoreType == "2" ? "선항영향력가게" : "급식카드 가맹점"
       }
       
   }
}


