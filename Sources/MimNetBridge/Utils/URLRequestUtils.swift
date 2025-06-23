// URLRequestUtils.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

import Foundation

struct URLRequestUtils {
    
    private static let pathDelimitorCharacterSet = CharacterSet(charactersIn: "/")
    
    private let requestHeaderProcessor: RequestHeaderProcessing
    
    init(requestHeaderProcessor: RequestHeaderProcessing = RequestHeaderProcessor()) {
        self.requestHeaderProcessor = requestHeaderProcessor
    }
    
    
    func buildURLComponents(serviceEndpoint: ServiceEndpoint) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = serviceEndpoint.scheme.rawValue
        components.host = serviceEndpoint.uriBase
        components.path = serviceEndpoint.pathComponents.reduce("") { result, element in
            let sanitizedElement = element.trimmingCharacters(in: Self.pathDelimitorCharacterSet)
            return "\(result)/\(sanitizedElement)"
        }
        
        return components
    }
    
    func buildURLRequest(serviceRequest: ServiceRequest) throws -> URLRequest {
        
        let requestHeaders = try requestHeaderProcessor.buildHeaders(
            headerBuilders: serviceRequest.headerBuilders,
            requestBody: serviceRequest.body ?? "",
            serviceContext: serviceRequest.serviceContext)
        
        guard let url = buildURLComponents(serviceEndpoint: serviceRequest.serviceEndpoint).url else {
            throw MIMNetBridgeError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = serviceRequest.serviceEndpoint.httpMethod.rawValue
        
        if serviceRequest.serviceEndpoint.httpMethod == .post && serviceRequest.body != nil {
            request.httpBody = serviceRequest.body!.data(using: .utf8)!
        }
        
        for header in requestHeaders {
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        
        return request
    }
    
}
