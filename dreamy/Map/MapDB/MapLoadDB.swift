//
//  LoadDB.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/26.
//

import Foundation
import Alamofire

func MyPositionRequest(completion: @escaping () -> Void ) { // 내 위치 리퀘스트
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/map/MyPosition?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "myPositionLng" : moMapPointGeo.longitude,
        "myPositionLat" : moMapPointGeo.latitude,
        "mbr" : 3000
       ]
       
    
       // [http 요청 수행 실시]
       print("주 소 :: ", url)
       print("데이터 :: ", queryString.description)
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseDecodable(of: MyPositionModel.self) { response in
           switch response.result {
           case .success(_):
               do {
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")

                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end postMyPositionRequest

func keywordSearchRequest(keyword: String, completion: @escaping () -> Void ) { // 키워드 검색
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/map/KeywordSearch?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "myPositionLng" : moMapPointGeo.longitude,
        "myPositionLat" : moMapPointGeo.latitude,
        "mbr" : 3000,
        "Keyword" : keyword
       ]
       
    
       // [http 요청 수행 실시]
       print("-------------------------------")
       print("주 소 :: ", url)
       print("데이터 :: ", queryString.description)
       print("")
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseDecodable(of: MyPositionModel.self) { response in
           switch response.result {
           case .success(let res):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                   items.removeAll()    // 모든 데이터 초기화
                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end keywordSearchRequest

func chooseCategoryRequest(Category: Int, completion: @escaping () -> Void ) {  // 대분류 카테고리 선택
    
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/map/Choose/Category?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "myPositionLng" : moMapPointGeo.longitude,
        "myPositionLat" : moMapPointGeo.latitude,
        "mbr" : 3000,
        "Category" : Category
       ]
       
    
       // [http 요청 수행 실시]
       print("")
       print("====================================")
//       print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실시]")
       print("-------------------------------")
       print("주 소 :: ", url)
       print("-------------------------------")
       print("데이터 :: ", queryString.description)
       print("====================================")
       print("")
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseDecodable(of: MyPositionModel.self) { response in
           switch response.result {
           case .success(_):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                   items.removeAll()   // items 초기화
                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end chooseCategoryRequest

func chooseSubCategoryRequest(Category: Int, SubCategory: Int, completion: @escaping () -> Void ) {  //소분류 카테고리 선택 - 카페, 편의점, 마트 등
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/map/Choose/SubCategory?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "myPositionLng" : moMapPointGeo.longitude,
        "myPositionLat" : moMapPointGeo.latitude,
        "mbr" : 3000,
        "Category" : Category,
        "SubCategory" : SubCategory
       ]
       
       // [http 요청 수행 실시]
       print("")
       print("====================================")
//       print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실시]")
       print("-------------------------------")
       print("주 소 :: ", url)
       print("-------------------------------")
       print("데이터 :: ", queryString.description)
       print("====================================")
       print("")
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseDecodable(of: MyPositionModel.self) { response in
           switch response.result {
           case .success(_):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                   items.removeAll()   // items 초기화
                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end chooseSubCategoryRequest

func chooseStoreTypeRequest(StoreType: Int, completion: @escaping () -> Void ) {  // 선한영향력/가맹점 선택
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/map/Choose/StoreType?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "myPositionLng" : moMapPointGeo.longitude,
        "myPositionLat" : moMapPointGeo.latitude,
        "mbr" : 3000,
        "StoreType" : StoreType,
       ]
       
       // [http 요청 수행 실시]
       print("주 소 :: ", url)
       print("-------------------------------")
       print("데이터 :: ", queryString.description)
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseDecodable(of: MyPositionModel.self) { response in
           switch response.result {
           case .success(_):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                   items.removeAll()   // items 초기화
                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end chooseStoreTypeRequest

func storeDetailRequest(StoreID: Int, StoreType: String, completion: @escaping () -> Void ) {  // 가게 셀 클릭시 상세페이지
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/map/StoreDetail?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "StoreID" : StoreID,
        "StoreType" : StoreType
       ]
       
       // [http 요청 수행 실시]
       print("주 소 :: ", url)
       print("-------------------------------")
       print("데이터 :: ", queryString.description)
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseDecodable(of: MyPositionModel.self) { response in
           switch response.result {
           case .success(_):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                   items.removeAll()   // items 초기화
                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end storeDetailRequest

func bookMarkList(completion: @escaping () -> Void ) {  // 북마크 리스트 조회
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/Bookmark/list?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "UserID" : userInfo.string(forKey: "User_Email")!
       ]
       
       // [http 요청 수행 실시]
       print("주 소 :: ", url)
       print("-------------------------------")
       print("데이터 :: ", queryString.description)
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseDecodable(of: MyPositionModel.self) { response in
           switch response.result {
           case .success(_):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                   items.removeAll()   // items 초기화
                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end bookMarkList

func bookMarkAdd(completion: @escaping () -> Void ) {  // 북마크 추가
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/Bookmark/add?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "UserID" : userInfo.string(forKey: "User_Email")!,
        "StoreID" : items[0].StoreID,
        "StoreType" : items[0].StoreType
       ]
       
       // [http 요청 수행 실시]
       print("주 소 :: ", url)
       print("-------------------------------")
       print("데이터 :: ", queryString.description)
       
       AF.request(
           url, // [주소]
           method: .post, // [전송 타입]
           parameters: queryString, // [전송 데이터]
           encoding: URLEncoding.queryString, // [인코딩 스타일]
           headers: header // [헤더 지정]
       )
       .validate(statusCode: 200..<300)
       .responseData() { response in
           switch response.result {
           case .success(_):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")
                  
                   print("====================================")
                   print("")
                   completion()
                   // [비동기 작업 수행]
                   DispatchQueue.main.async {
//                       items.append(contentsOf: Model.items)
                   }
               }
               catch (let err){
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("catch :: ", err.localizedDescription)
                   print("====================================")
                   print("")
               }
               break
           case .failure(let err):
               print("")
               print("====================================")
//               print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 요청 실패]")
               print("-------------------------------")
               print("응답 코드 :: ", response.response?.statusCode ?? 0)
               print("-------------------------------")
               print("에 러 :: ", err.localizedDescription)
               print("====================================")
               print("")
               break
           }//end switch
       }// end responseDecodable
    
}//end bookMarkList
