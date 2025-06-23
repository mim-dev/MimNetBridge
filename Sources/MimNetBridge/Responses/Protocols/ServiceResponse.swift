// ServiceResponse.swift
// MimNetBridge
//
// Copyright © 2025 Luther Stanton (mim-dev). All rights reserved.
//  

import Foundation

public protocol ServiceResponse {
    var headers: [AnyHashable: Any]? { get }
    var data: Data? { get }
}
