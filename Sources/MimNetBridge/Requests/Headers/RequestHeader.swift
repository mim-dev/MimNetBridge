// RequestHeader.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

public struct RequestHeader {
    
    let name: String
    let value: String
    
    func toPair() -> [String: String] {
        return [name: value]
    }
}
