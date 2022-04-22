//
//  AuthModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation

class AuthModel {
    static var authModel = AuthModel()
    static var loginDelegate: LoginViewControllerDelegate?
    
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
            module: "login",
            getParams: [:],
            body: ["gmail": login,
                   "password": password
                  ], complition: signInCallback)
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
}

extension Dictionary {
    func convertToJSONString() -> String?{
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(data: jsonData, encoding: String.Encoding.utf8)
        } catch {
            return nil
        }
    }
}

extension String {
   func convertDict() -> [String: Any]? {
       do {
           let json = try JSONSerialization.jsonObject(with: self.data(using: String.Encoding.utf8)!, options: []) as? [String: Any]
           return json
       } catch {
           return nil
       }
       
   }
}
