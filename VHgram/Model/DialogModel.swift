//
//  DialogModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation

class DialogModel {
    var dialogName:String = ""
    
    var messages = [
        ["id":"9","senderid":"5","sender":"Katya ;)","message":"you","attachments":"","send_time":"13-35","avatar":""]
    ]
    
    func messagesCnt() -> Int {
        return messages.count
    }
    
    func getMessage(id: Int) -> [String:String] {
        return messages[id]
    }
    
    func refetchData() {
        NetworkLayer.sendAuthorizedPOSTRequest(module: "getdialog", getParams: ["dialog":ApplicationGlobals.activeDialog], body: [:], complition: dialogsRequestCallback)
    }
    
    private func dialogsRequestCallback(response: Any) {
        
        let array = response as? [String:Any]
        print(array)
        
    }
}
