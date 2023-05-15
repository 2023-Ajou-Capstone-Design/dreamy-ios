//
//  LoginLoadDB.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/15.
//

import Foundation
import Alamofire

func loginReqeust() {  // 로그인 계정 추가
       
       // [http 요청 주소 지정]
       let url = "http://3.130.31.88:5000/LogIn?"
       
       // [http 요청 헤더 지정]
       let header : HTTPHeaders = [
           "Content-Type" : "application/json"
       ]
       
       // [http 요청 파라미터 지정 실시]
       let queryString : Parameters = [
        "Town" : userInfo.string(forKey: "User_Town") ?? "테스트 동네",
        "AKA" : userInfo.string(forKey: "User_AKA") ?? "테스트 닉네임",
        "UserType" : userInfo.string(forKey: "User_Type") ?? "테스트 유저타입",
        "Card" : userInfo.string(forKey: "User_cardNumber") ?? "테스트 카드넘버",
        "UserPhoto" : "",
        "UserID" : userInfo.string(forKey: "User_Email") ?? "테스트 유저ID"
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
       .responseData { response in
           switch response.result {
           case .success(_):
               do {

                   print("응답 코드 :: ", response.response?.statusCode ?? 0)
                   print("-------------------------------")

//                   guard let Model = response.value else {return}
//                   print(Model.items, Model.total)
//                   items.append(contentsOf: Model.items)
                   
                   print("====================================")
                   print("")
//                   completion()
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

