//
//  ProfileModel.swift
//  VHgram
//
//  Created by Владислав on 22.04.2022.
//

import Foundation

class ProfileModel {
    let uid: Int
    var name: String = ""
    var avatar: String = ""
    var profileDelegate: ProfileViewController?
    
    public init(uid: Int) {
        self.uid = uid
    }
    
    func getName() -> String {
        return name
    }
    
    func getAvatar() -> String {
        return avatar
    }
    
    func refetchData() {
        NetworkLayer.sendAuthorizedPOSTRequest(
            module: "getuserinfo",
            getParams: ["id":String(self.uid)], body: [:], complition: profileFetchCallback)
    }
    
    private func profileFetchCallback(response: Any) {
        let res = response as? [String: Any]
        name = res?["name"] as? String ?? ""
        avatar = res?["avatar"] as? String ?? ""
        DispatchQueue.main.async { [self] in
            profileDelegate?.fillData(name: name, avatar: avatar)
        }
        
    }
}
