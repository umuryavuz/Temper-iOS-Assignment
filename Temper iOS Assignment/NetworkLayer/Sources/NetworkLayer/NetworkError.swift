//
//  File.swift
//  
//
//  Created by Umur Yavuz on 02/10/2023.
//

import Foundation

public enum NetworkError: Error {
    case badRequest
    case unauthorized
    case notFound
    case serializationError(String)
    case unknownError(String)
}
