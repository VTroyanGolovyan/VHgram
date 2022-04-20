//
//  ChatsModel.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import Foundation
import UIKit

class ChatsModel {
    var chatsViewDelegate:UITableView?
    
    var chats:[[String:String]] = [
    ]
    
    public init() {
        NetworkLayer.sendAuthorizedPOSTRequest(module: "getuserdialogs", getParams: [:], body: [:], complition: chatsRequestCallback)
    }
    
    func Count() -> Int {
        return chats.count
    }
    
    func GetChat(index: Int) -> Dictionary<String, String> {
        return chats[index]
    }
    
    private func chatsRequestCallback(response: Any) {
        let chatsArray = response as? [[String:Any]]
        var chatsArrayData: [[String:String]] = []
        for chat in chatsArray! {
            var new_dict: [String:String] = [:]
            for (key, value) in chat {
                new_dict[key] = value as? String
                if new_dict[key] == nil {
                    new_dict[key] =  String(value as? Int ?? 0)
                }
            }
            chatsArrayData.append(new_dict)
        }
        chats = chatsArrayData
        if chatsViewDelegate != nil {
            DispatchQueue.main.async { [self] in
                chatsViewDelegate?.reloadData()
            }
        }
    }
}
