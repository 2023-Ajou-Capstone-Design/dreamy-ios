//
//  UserDefaultManager.swift
//  ExChat
//
//  Created by 장준모 on 2023/05/17.//

import Foundation

struct UserDefaultManager {
    static var displayName: String {
        get {
            UserDefaults.standard.string(forKey: "DisplayName") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "DisplayName")
        }
    }
}
