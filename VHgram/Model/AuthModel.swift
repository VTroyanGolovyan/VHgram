//
//  AuthModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation
import UIKit

class AuthModel {
    static var authModel = AuthModel()
    static var loginDelegate: LoginViewControllerDelegate?
    static var labelDelegate: UILabel?
    static var regLabelDelegate: UILabel?
    
    var username: String?
    var token: String?
    var avatarURL: String?
    var userName: String?
    var uid: Int?
    var hasSigned: Bool = false
    
    static func GetInstance() -> AuthModel {
        return authModel
    }
    
    static func isSigned() -> Bool {
        return AuthModel.GetInstance().hasSigned
    }
    
    static func signOut() {
        AuthModel.GetInstance().hasSigned = false
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "auth_data")
    }
    
    static func signIn(login: String,  password: String) {
        NetworkLayer.sendPOSTRequest(
            module: BackendModules.signIn,
            getParams: [:],
            body: [
                "gmail": login,
                "password": password
            ],
            complition: signInCallback
        )
    }
    
    static private func signInCallback(response: Any?) {
        let res = response! as? [String: Any]
        if res?["status"] != nil {
            if res?["status"] as! Int == 1 {
                AuthModel.GetInstance().token = res?["hash"] as? String
                AuthModel.GetInstance().username = res?["name_and_second_name"] as? String
                AuthModel.GetInstance().uid = res?["id"] as? Int
                AuthModel.GetInstance().avatarURL = res?["avatar"] as? String
                AuthModel.GetInstance().username = res?["name_and_second_name"] as? String
                AuthModel.GetInstance().hasSigned = true
                let defaults = UserDefaults.standard
                defaults.set(response, forKey: "auth_data")
                DispatchQueue.main.async {
                    loginDelegate?.switchAppController()
                }
            } else {
                DispatchQueue.main.async {
                    labelDelegate?.text = res?["text"] as? String
                }
            }
        }
    }
    
    private init() {
        let defaults = UserDefaults.standard
        let auth_data = defaults.dictionary(forKey: "auth_data")
        if auth_data != nil {
            self.token = auth_data?["hash"] as? String
            self.username = auth_data?["name_and_second_name"] as? String
            self.uid = auth_data?["id"] as? Int
            self.avatarURL = auth_data?["avatar"] as? String
            self.username = auth_data?["name_and_second_name"] as? String
            self.hasSigned = true
        }
    }
    
    static func signUp(name: String, lastName: String, login: String,  password: String, checkPassword: String) {
        NetworkLayer.sendPOSTRequest(
            module: BackendModules.signUp,
            getParams: [:],
            body: [
                "name": name,
                "second_name": lastName,
                "gmail": login,
                "password": password,
                "chek": checkPassword,
                "country": "1",
                "city": "1"
            ], complition: signUpCallback)
    }
    
    static private func signUpCallback(response: Any?) {
        let res = response! as? [String: Any]
        DispatchQueue.main.async {
            regLabelDelegate?.text = res?["text"] as? String
        }
    }
    
}
