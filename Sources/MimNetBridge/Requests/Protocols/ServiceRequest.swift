//  ServiceRequest.swift
//  MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//

public protocol ServiceRequest {
    
    var serviceEndpoint: ServiceEndpoint { get }
    var headerBuilders: [HeaderBuilder] { get }
    var serviceContext: ServiceContext { get }
    var body: String? { get}
}
