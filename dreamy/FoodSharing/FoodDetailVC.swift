//
//  FoodDetailVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/08.
//

import UIKit
import FirebaseAuth
import Firebase


var foodDetailS = FoodSharingCellModel(Photo1: nil, Photo2: nil, Photo3: nil, Contents: "contents", Title: "title", Town: nil, UploadTime: "uploadTime", UserID: "userID", WritingID: "writingID", AKA: nil)

var newChannel = Channel(name: "")

class FoodDetailVC: UIViewController, sendFoodSharingDetail {
    
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodDetailAKA: UILabel!
    @IBOutlet var foodDetailTown: UILabel!
    @IBOutlet var foodDetailUploadTime: UILabel!
    @IBOutlet var foodDetailTitle: UILabel!
    @IBOutlet var foodDetailContents: UILabel!
    
    private let overlayView = UIView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    private let channelStream = ChannelFirestoreStream()
    var currentUser: User = Auth.auth().currentUser!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configure()

    }
    @IBAction func chatBtn(_ sender: UIButton) {//채팅하기 버튼
        channelStream.createChannel(with: foodDetailTitle.text!)//채널을 만들고
        newChannel = Channel(name: foodDetailTitle.text ?? "")

        let chatVC = ChatVC(user: Auth.auth().currentUser!, channel: channels.first!)
//        navigationController?.pushViewController(chatVC, animated: true)
//        self.navigationController?.pushViewController(chatVC, animated: true)
        
        let navigationController = UINavigationController(rootViewController: chatVC)
//        navigationController.modalPresentationStyle = .fullScreen // Set the desired presentation style

        present(navigationController, animated: true, completion: nil)
        

    }
    
    @objc func editButtonTapped() {
           // Perform actions when the button is tapped
           // E.g., present a view controller for editing or delete items
           // Or toggle the editing mode of a UITableView
           print("Edit button tapped")
       }
    
    func sendFoodSharingDetailInfo(foodDetail: FoodSharingCellModel) {  //푸드쉐어링 상세페이지 DB로 불러와 채우기
        
        FoodShareDetail(userID: foodDetail.UserID, writingID: foodDetail.WritingID){
            
            //            if let foodImage = foodList[0].Photo1{
            //
            //            }
            if let aka = foodList.first?.AKA{
                self.foodDetailAKA.text = aka
            }else{
                
            }
            
            if let town = foodList.first?.Town{
                self.foodDetailTown.text = town
            }else{
                
            }
            
            if let uptime = foodList.first?.UploadTime{
                self.foodDetailUploadTime.text = uptime
            }else{
                
            }
            
            if let title = foodList.first?.Title{
                self.foodDetailTitle.text = title
            }else{
                
            }
            
            if let contents = foodList.first?.Contents{
                self.foodDetailContents.text = contents
            }else{
                
            }
            print("푸드쉐어링 글 상세 Delegate 성공")
        }
        
    }
    
    func configure(foodDetail: FoodSharingCellModel) {

        foodDetailAKA.text = foodDetail.AKA
//        foodDetailAKA.isHidden = false
        
        foodDetailTown.text = foodDetail.Town
//        foodDetailTown.isHidden = false

        foodDetailTitle.text = foodDetail.Title
//        foodDetailTitle.isHidden = false

        foodDetailContents.text = foodDetail.Contents
        foodDetailUploadTime.text = foodDetail.UploadTime
        
    }
    
    func foodGetDetail(foodDetail: FoodSharingCellModel, completion: @escaping () -> Void) {
        
//       var foodDetail = FoodSharingCellModel(Photo1: nil, Photo2: nil, Photo3: nil, Contents: "contents", Title: "title", Town: nil, UploadTime: "uploadTime", UserID: "userID", WritingID: "writingID")
        
         FoodShareDetail(userID: foodDetail.UserID, writingID: foodDetail.WritingID){
           
             self.configure(foodDetail: foodDetailS)
             print("푸드쉐어링 글 상세 Delegate 성공")
        }
        completion()

    }   //end of foodGetDetail
    
}
