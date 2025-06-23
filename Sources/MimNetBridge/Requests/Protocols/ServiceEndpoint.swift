// ServiceEndpoint.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

public protocol ServiceEndpoint {
    
    var scheme: HTTPScheme { get }
    var uriBase: String { get }
    var pathComponents: [String] { get }
    var httpMethod: HTTPMethod { get }
}
