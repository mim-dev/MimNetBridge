// HeaderBuilder.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

public protocol HeaderBuilder {
    func build(requestBody: String, serviceContext: ServiceContext) throws -> RequestHeader
}
