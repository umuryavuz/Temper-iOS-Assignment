//
//  File.swift
//  
//
//  Created by Umur Yavuz on 01/10/2023.
//

import Foundation
import Alamofire

final class AlamofireLogger: EventMonitor {

    func requestDidResume(_ request: Request) {
        
        let allHeaders = request.request.flatMap { $0.allHTTPHeaderFields.map { $0.description } } ?? "None"
        let headers = """
        ⚡️⚡️⚡️⚡️ Request Started: \n \(request)
        ⚡️⚡️⚡️⚡️ Headers: \n \(allHeaders)
        """
        NSLog(headers)


        let body = request.request.flatMap { $0.httpBody.map { String(decoding: $0, as: UTF8.self) } } ?? "None"
        let message = """
        ⚡️⚡️⚡️⚡️ Request Started: \n \(request)
        ⚡️⚡️⚡️⚡️ Body Data: \n \(body)
        """
        NSLog(message)
        
    }

    func request<Value>(_ request: DataRequest, didParseResponse response: AFDataResponse<Value>) {
        let message = """
        ⚡️⚡️⚡️⚡️ Response Received: \n \(response.debugDescription)
        """
        NSLog(message)
        NSLog("⚡️⚡️⚡️⚡️ Response All Headers: \n \(String(describing: response.response?.allHeaderFields))")
        
    }
}
