// RequestHeaderProcessor.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

struct RequestHeaderProcessor: RequestHeaderProcessing {
    
    func buildHeaders(headerBuilders: [HeaderBuilder],
                      requestBody: String,
                      serviceContext: ServiceContext) throws -> [RequestHeader] {
        
        var headers = [RequestHeader]()
        var seenNames = Set<String>()
        
        for requestHeaderBuilder in headerBuilders {
           
            let newHeader = try requestHeaderBuilder.build(requestBody: requestBody,
                                                    serviceContext: serviceContext)
            
            guard seenNames.insert(newHeader.name.lowercased()).inserted else {
                        throw MIMNetBridgeError.duplicateHeader
            }
            
            headers.append(newHeader)
        }
        
        return headers
    }
}
