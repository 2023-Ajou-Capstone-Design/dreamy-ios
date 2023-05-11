//
//  FoodShareLoadDB.swift
//  dreamy
//
//  Created by 장준모 on 2023/04/16.
//

import Foundation
import Alamofire


func FoodShareGetList(completion: @escaping () -> Void ) { // 푸드쉐어링 리스트 업로드
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/FoodShare/getList"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "Town" : "수원시 영통구 원천동"
        
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
       .responseDecodable(of: FoodShareGetListModel.self) { response in
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
                   
                   foodList.append(contentsOf: Model.items)
                   
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
    
}//end FoodShareGetList

func FoodShareDetail(userID: String, writingID: String,completion: @escaping () -> Void )  { // 푸드쉐어링 상세페이지
       
//    var foodDetailS = FoodSharingCellModel(Photo1: nil, Photo2: nil, Photo3: nil, Contents: "contents", Title: "title", Town: nil, UploadTime: "uploadTime", UserID: "userID", WritingID: "writingID")

       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/FoodShare/Detail"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
//        "UserID" : "Tester",//임시로 Tester 넣어둠
        "UserID" : userID,
        "WritingID" : writingID
        
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
       .responseDecodable(of: FoodShareGetListModel.self) { response in
           switch response.result {
           case .success(_):
               do {
                   print("")
                   print("====================================")
//                   print("[\(self.ACTIVITY_NAME) >> postRequest() :: Post 방식 http 응답 확인]")
                   print("-------------------------------")
                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")

//                   foodList.removeAll() //푸드리스트 초기화
                   guard let Model = response.value else {return}
                   print(Model.items, Model.total)
                   
//                   foodList.append(contentsOf: Model.items)
                   
                   foodDetailS = Model.items[0]
                   
                   
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
    
//    return foodDetailS
    
}//end FoodShareGetList
