//
//  StreamError.swift
//  ExChat
//
//  Created by 장준모 on 2023/05/17.
//

import Foundation

enum StreamError: Error {
    case firestoreError(Error?)
    case decodedError(Error?)
}
