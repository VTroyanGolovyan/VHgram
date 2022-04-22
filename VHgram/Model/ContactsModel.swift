//
//  ContactsModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation

//
//  ChatsModel.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import Foundation
import UIKit

class ContactsModel {
    var contactsViewDelegate:UITableView?
    
    var contacts:[[String:String]] = [
    ]
    
    public init() {
        refetchData()
    }
    
    func Count() -> Int {
        return contacts.count
    }
    
    func GetContact(index: Int) -> Dictionary<String, String> {
        return contacts[index]
    }
    
    func refetchData() {
        NetworkLayer.sendAuthorizedPOSTRequest(module: "contacts", getParams: [:], body: [:], complition: chatsRequestCallback)
    }
    
    private func chatsRequestCallback(response: Any) {
        let Array = response as? [[String:Any]]
        var ArrayData: [[String:String]] = []
        for chat in Array! {
            var new_dict: [String:String] = [:]
            for (key, value) in chat {
                new_dict[key] = value as? String
                if new_dict[key] == nil {
                    new_dict[key] =  String(value as? Int ?? 0)
                }
            }
            ArrayData.append(new_dict)
        }
        contacts = ArrayData
        if contactsViewDelegate != nil {
            DispatchQueue.main.async { [self] in
                contactsViewDelegate?.reloadData()
            }
        }
    }
}
