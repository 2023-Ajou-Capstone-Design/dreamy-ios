//
//  FoodRegisterVC.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/08.
//

import UIKit
import MobileCoreServices

class FoodRegisterVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var foodTitle: UITextField!   //글제목
    @IBOutlet var foodContent: UITextField! //글내용
    @IBOutlet var photoRegisterImage: UIImageView!  //  카메라 이미지 클릭시 사진업로드
    var capturedImage: UIImage! //담을 사진
    var base64Image: String!
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoRegisterImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.photoCapture)))//  카메라 이미지 클릭 이벤트
        
    }
    
    @objc func photoCapture(sender: UITapGestureRecognizer) {//사진 촬영 함수
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){ //카메라 사용 가능 여부 확인
            
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.mediaTypes = ["public.image"]
            imagePicker.allowsEditing = false   //편집 허용 X
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! NSString
        
        if mediaType.isEqual(to: "public.image" as String){ //미디어가 사진이면
            capturedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            
            photoRegisterImage.image = capturedImage
            picker.dismiss(animated: true)
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {    //사진 찍기를 취소하는 경우
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func foodSharingRegisterBtn(_ sender: UIButton) { //등록하기 버튼
        
        if let title = foodTitle.text, let content = foodContent.text {
            

            FoodShareAdd(title: title, contents: content, photo1: nil, photo2: nil, photo3: nil){
                
                NotificationCenter.default.post(name: .loadDataNotification, object: nil)
                
                DispatchQueue.main.async { [weak self] in
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
        
        }//end 등록 버튼

}


extension Notification.Name {//로드 하라는 알림
    static let loadDataNotification = Notification.Name("LoadDataNotification")
}


// UIImage를 Base64 문자열로 인코딩하는 함수
func encodeImageToBase64(image: UIImage) -> String? {
    if let imageData = image.jpegData(compressionQuality: 1.0) { // UIImage를 PNG 데이터로 변환
        let base64String = imageData.base64EncodedString() // Base64로 인코딩
        return base64String
    }
    return nil
}
