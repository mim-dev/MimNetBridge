// RequestHeaderProcessing.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

protocol RequestHeaderProcessing {
    func buildHeaders(headerBuilders: [HeaderBuilder],
                      requestBody: String,
                      serviceContext: ServiceContext) throws -> [RequestHeader]
}
