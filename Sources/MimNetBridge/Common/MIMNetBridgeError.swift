// MIMNetBridgeError.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

public enum MIMNetBridgeError : Error {
    case unknownError
    case dataParsingError
    case duplicateHeader
    case badContext
    case invalidURL
    case invalidResponse
    case networkError(Int)
}
