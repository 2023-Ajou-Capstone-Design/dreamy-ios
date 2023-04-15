//
//  StoreDetailViewController.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/10.
//

import UIKit

class StoreDetailViewController: UIViewController {
    
    @IBOutlet var storeImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
