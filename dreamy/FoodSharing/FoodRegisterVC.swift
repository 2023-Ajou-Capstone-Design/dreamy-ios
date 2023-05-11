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
    
    let imagePicker: UIImagePickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.photoRegisterImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.photoCapture)))//  카메라 이미지 클릭 이벤트
        
    }
    
    @objc func photoCapture(sender: UITapGestureRecognizer) {//사진 촬영 함수
        if(UIImagePickerController.isSourceTypeAvailable(.camera)){ //카메라 사용 가능 여부 확인
            
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
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
            
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {    //사진 찍기를 취소하는 경우
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func foodSharingRegisterBtn(_ sender: UIButton) {
        
    }
    
}
