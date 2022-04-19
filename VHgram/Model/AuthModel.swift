//
//  AuthModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation

class AuthModel {
    static let authModel = AuthModel()
    var username: String?
    var token: String?
    var refreshToken: String?
    static func SignIn(login: String,  password: String) {
        
    }
    private init() { }
}
