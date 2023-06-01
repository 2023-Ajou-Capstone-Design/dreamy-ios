//
//  FoodDetailVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/08.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

var foodDetailS = FoodSharingCellModel(Photo1: nil, Photo2: nil, Photo3: nil, Contents: "contents", Title: "title", Town: nil, UploadTime: "uploadTime", UserID: "userID", WritingID: "writingID", AKA: nil)

var newChannel = Channel(name: "")

class FoodDetailVC: UIViewController, sendFoodSharingDetail {
    
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var foodDetailAKA: UILabel!
    @IBOutlet var foodDetailTown: UILabel!
    @IBOutlet var foodDetailUploadTime: UILabel!
    @IBOutlet var foodDetailTitle: UILabel!
    @IBOutlet var foodDetailContents: UILabel!
    
    @IBOutlet var chatBtn: UIButton!
    @IBOutlet var editBtn: UIButton!
    @IBOutlet var removeBtn: UIButton!
    
    private let overlayView = UIView()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)

    private let channelStream = ChannelFirestoreStream()
    var currentUser: User = Auth.auth().currentUser!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        configure()

        //알림이 오면 리로드
        NotificationCenter.default.addObserver(self, selector: #selector(receiveNotification1(_:)), name: .loadDataNotification, object: nil)
        
    }
    
    @objc func receiveNotification1(_ notification: Notification) {//알림시 리로드
        // Call the loadData() function here
        FoodShareDetail(userID: foodDetailS.UserID, writingID: foodDetailS.WritingID ){
            self.configure(foodDetail: foodDetailS)
            print("푸드 상세 리로드")
        }
    }
    
    @IBAction func chatBtn(_ sender: UIButton) {//채팅하기 버튼
        
        let channelVC = ChannelVC(currentUser: Auth.auth().currentUser!)
        channelVC.setupListener()
        channelVC.channelStream.createChannel(with: foodDetailTitle.text!)

        newChannel = Channel(id: foodList.first?.UserID, name: foodDetailTitle.text!)
//        newChannel = Channel(id: document.documentID, name: foodDetailTitle.text!)
        
        channelVC.channels.append(newChannel)

        let chatVC = ChatVC(user: Auth.auth().currentUser!, channel: channelVC.channels.first!)
        print(channelVC.channels.first!)
        navigationController?.pushViewController(chatVC, animated: true)

    }//end of chatBtn
    
    @IBAction func editBtn(_ sender: UIButton) {//수정하기 버튼
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "foodShareModifyVC") as? FoodShareModifyVC /* down casting */ else { return }
        viewController.foodtitle = foodDetailTitle.text
        viewController.foodcontents = foodDetailContents.text
             self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func removeBtn(_ sender: UIButton) {//삭제하기 버튼
        
        let sheet = UIAlertController(title: nil, message: "등록하신 글을 삭제하시겠습니까?", preferredStyle: .alert)
        sheet.addAction(UIAlertAction(title: "삭제하기", style: .destructive, handler: { [self] _ in FoodShareDel(writingID: foodDetailUploadTime.text!){
            
            self.navigationController?.popViewController(animated: true)
//            NotificationCenter.default.post(name: .loadDataNotification, object: nil)
            
        } }))
        sheet.addAction(UIAlertAction(title: "아니요", style: .cancel, handler: { _ in print("no 클릭") }))

        present(sheet, animated: true)
//        FoodShareDel(writingID: foodDetailUploadTime.text!)
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
        
        if foodDetail.UserID == userInfo.string(forKey: "User_Email"){
            editBtn.isHidden = false
            removeBtn.isHidden = false
            chatBtn.isHidden = true
        }
        else{
            editBtn.isHidden = true
            removeBtn.isHidden = true
            chatBtn.isHidden = false
        }
        
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
