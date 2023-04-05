//
//  LoadDB.swift
//  dreamy
//
//  Created by 장준모 on 2023/03/26.
//

import Foundation
import Alamofire

func MyPositionRequest(completion: @escaping () -> Void ) {
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/MyPosition?"
       
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
           case .success(let res):
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

func keywordSearchRequest(keyword: String, completion: @escaping () -> Void ) {
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/KeywordSearch?"
       
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

func chooseCategoryRequest(Category: Int, completion: @escaping () -> Void ) {  //대분류 카테고리 선택
    
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/Choose/Category?"
       
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
           case .success(let res):
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

func chooseSubCategoryRequest(Category: Int, SubCategory: Int, completion: @escaping () -> Void ) {  //대분류 카테고리 선택
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/Choose/SubCategory?"
       
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
           case .success(let res):
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
