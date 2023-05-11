//
//  UserModel.swift
//  dreamy
//
//  Created by 장준모 on 2023/05/07.
//

import Foundation

let userInfo = UserDefaults.standard    //사용자 정보를 담을 UserDefaults

struct userModel: Codable{
    var UserID: String?
    var AKA: String?
    var UserType: String?
    var Card: String?
    var Town: String?
    
    
}
