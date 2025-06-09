//
//  KeychainError.swift
//  Data
//
//  Created by 김은찬 on 6/4/25.
//


import Foundation

public enum KeychainError: Error {
    
    case keyDuplicated
    case keyDoesNotExist
}