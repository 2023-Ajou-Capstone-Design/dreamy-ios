//
//  NSObject.swift
//  ExChat
//
//  Created by 장준모 on 2023/05/17.//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
