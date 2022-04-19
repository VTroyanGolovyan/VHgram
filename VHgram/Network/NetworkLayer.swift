//
//  NetworkLayer.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation

class NetworkLayer {
    public static var baseServerURL: String = "http://194.87.236.128/VHchat-Server/server/";
    
    public static func sendSignInRequest(email: String, password: String) {
        let url = URL(string: baseServerURL + "?module=login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let _: [String: Any] = [
            "gmail": email,
            "password": password
        ]
      
    }
}
