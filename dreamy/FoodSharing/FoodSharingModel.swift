//
//  FoodSharingModel.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/16.
//

import Foundation
import Alamofire

struct FoodSharingCellModel: Codable{   //푸드셰어링 리스트 셀에 들어갈 모델
    
    let Photo1, Photo2, Photo3: String? //임시로 Photo를 String으로 지정
    let Contents: String?
    let Title: String
    let Town: String?
    let UploadTime: String
    let UserID: String
    let WritingID: String
    
    enum CodingKeys: String, CodingKey {
        case Photo1 = "Photo1"
        case Photo2 = "Photo2"
        case Photo3 = "Photo3"
        case Contents = "Contents"
        case Title = "Title"
        case Town = "Town"
        case UploadTime = "UploadTime"
        case UserID = "UserID"
        case WritingID = "WritingID"
    }
}

struct FoodShareGetListModel: Codable{
    let items: [FoodSharingCellModel]
    let total: Int
}
