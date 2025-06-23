// HTTPMethod.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

import Foundation

public class MimNetBridgeAPI {
    
    private let urlRequestUtils: URLRequestUtils
    
    init(urlRequestUtils: URLRequestUtils = URLRequestUtils()) {
        self.urlRequestUtils = urlRequestUtils
    }
    
    func execute<T: ServiceResponse, C>(serviceRequest: ServiceRequest,
                                        responseContext: C?,
                                        responseFactory: (Data?, [AnyHashable : Any], C?) throws -> T) async throws -> T {
        
        let request = try urlRequestUtils.buildURLRequest(serviceRequest: serviceRequest)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse {
                if (200..<300).contains(httpResponse.statusCode) {
                    let dataString = String(data: data, encoding: .utf8) ?? "No textual data"
                    print("Networking::execute() - status code:[\(httpResponse.statusCode)], response:[\(httpResponse.debugDescription)] responseBody:[\(dataString)])")
                    return try responseFactory(data, httpResponse.allHeaderFields, responseContext)
                } else {
                    let dataString = String(data: data, encoding: .utf8) ?? "No textual data"
                    print("Networking::execute() - status code:[\(httpResponse.statusCode)], response:[\(httpResponse.debugDescription)] responseBody:[\(dataString)])")
                    throw MIMNetBridgeError.networkError(httpResponse.statusCode)
                }
            } else {
                print("Networking::execute() - did not receive the expected HTTPURLResponse")
                throw MIMNetBridgeError.invalidResponse
            }
        } catch {
            print("Request failed: \(error)")
            throw error
        }
    }
}
