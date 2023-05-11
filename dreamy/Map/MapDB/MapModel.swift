//
//  Struct.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/26.
//

import Foundation
import Alamofire

//struct StoreInformation {   //가게 정보
//    var storeImage: UIImage?
//    var storeName: String
//    var storeCategory: String
//
//}
//
//struct LocationInfo {//위도 경도
//    var latitude: Double?   //위도
//    var longitude: Double?  //경도
//}

struct StoreDB: Codable {
    let StoreID: Int
    let StoreType, StoreName: String
    let StorePointLat, StorePointLng : Double
    let Distance: Double?
    let Category, SubCategory, Address, DetailAddress: String?
    let DayStart, DayFinish, SatStart, SatFinish, HoliStart, HoliFinish, Item, Provided1, Provided2, Phone, StorePhoto, WorkDay : String?
    let CateName, SubCateName: String?  //카테,서브카테 네임
    
    enum CodingKeys: String, CodingKey {
        case StoreID = "StoreID"
        case StoreType = "StoreType"
        case StorePointLat = "StorePointLat"
        case StorePointLng = "StorePointLng"
        case StoreName = "StoreName"
        case Distance = "Distance"
        case Category = "Category"
        case SubCategory = "SubCategory"
        case Address = "Address"
        case DayStart = "DayStart"
        case DayFinish = "DayFinish"
        case SatStart = "SatStart"
        case SatFinish = "SatFinish"
        case HoliStart = "HoliStart"
        case HoliFinish = "HoliFinish"
        case Item = "Item"
        case Provided1 = "Provided1"
        case Provided2 = "Provided2"
        case Phone = "Phone"
        case StorePhoto = "StorePhoto"
        case WorkDay = "WorkDay"
        
        case CateName = "CateName"
        case SubCateName = "SubCateName"
        case DetailAddress = "DetailAddress"
    }
    
}
struct MyPositionModel: Codable {   //내위치 띄우기 모델
    let items: [StoreDB]
    let total: Int
    
//    enum CodingKeys: String, CodingKey {
//        case total = "total"
//        case items
//    }
    
//    init(from decoder: Decoder) throws {
//            let values = try decoder.container(keyedBy: CodingKeys.self)
//            items = (try? values.decode([MyPositionItem].self, forKey: .items)) ?? nil
//            total = (try? values.decode(Int.self, forKey: .total)) ?? nil
//        }
}

struct MyPositionItem: Codable {
    let distance: Double
       let storeID: Int
       let storeName: String
       let storePointLat: Double
       let storePointLng: Double
       let storeType: String
       
       enum CodingKeys: String, CodingKey {
           case distance = "Distance"
           case storeID = "StoreID"
           case storeName = "StoreName"
           case storePointLat = "StorePointLat"
           case storePointLng = "StorePointLng"
           case storeType = "StoreType"
       }
}

struct AFDataResponse<T: Codable>: Codable {
    
    // 응답 결과값
    let data: T?
    
    // 응답 코드
    let result_code: Int?
    
    // 응답 메시지
    let result_message: String?
    
    enum CodingKeys: CodingKey {
        case result_code, result_message, data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        result_code = (try? values.decode(Int.self, forKey: .result_code)) ?? nil
        result_message = (try? values.decode(String.self, forKey: .result_message)) ?? nil
        data = (try? values.decode(T.self, forKey: .data)) ?? nil
    }
}
