//
//  Struct.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/26.
//

import Foundation
import Alamofire

struct StoreInformation {   //가게 정보
    var storeImage: UIImage?
    var storeName: String
    var storeCategory: String
    
}

struct LocationInfo {//위도 경도
    var latitude: Double?   //위도
    var longitude: Double?  //경도
}

struct StoreDB {
    var StoreID, StoreType, Category, SubCategory, StorePoitLat, StorePoitLng, StoreName, Address : String,
        DayStart, DayFinish, SatStart, SatFinish, HoliStart, HoliFinish, Item, Provided1, Provided2, Phone, StorePhoto, WorkDay : String?
    
}
struct MyPositionModel: Codable {   //내위치 띄우기 모델
    let items: [MyPositionItem]
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
var datasource: [[String]] = [[]]

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

//switch (categoryname, subcategoryname){
//case ("1", "1"):
//    self.categoryName.text = "한식"
//case("1", "2"):
//    self.categoryName.text = "일식"
//case("1", "3"):
//    self.categoryName.text = "중식"
//case("1", "4"):
//    self.categoryName.text = "양식"
//case("1", "5"):
//    self.categoryName.text = "분식"
//case("1", "6"):
//    self.categoryName.text = "카페"
//case("1", "99"):
//    self.categoryName.text = "음식점"  //기타
//case("2", "1"):
//    self.categoryName.text = "대형마트"
//case("2", "2"):
//    self.categoryName.text = "편의점"
//case("2", "99"):
//    self.categoryName.text = "마트"   //기타
//case("4", "1"):
//    self.categoryName.text = "국어 교육"
//case("4", "2"):
//    self.categoryName.text = "영어 교육"
//case("4", "3"):
//    self.categoryName.text = "수학 교육"
//case("4", "4"):
//    self.categoryName.text = "스터디카페"
//case("4", "5"):
//    self.categoryName.text = "스포츠 교육"
//case("4", "5"):
//    self.categoryName.text = "교육"
//case("5", "99"):
//    self.categoryName.text = "생활"
//case("99", "99"):
//    self.categoryName.text = "기타"
//default: break
//}
