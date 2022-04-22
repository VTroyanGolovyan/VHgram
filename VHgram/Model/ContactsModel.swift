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
        let array = response as? [[String:Any]]
        if let arrayData = array?.getStringsDictArray() {
            contacts = arrayData
            if contactsViewDelegate != nil {
                DispatchQueue.main.async { [self] in
                    contactsViewDelegate?.reloadData()
                }
            }
        }
    }
}
