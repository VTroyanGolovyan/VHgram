//
//  ContactsModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation
import UIKit

class ContactsModel {
    var contactsViewDelegate:UITableView?
    
    var contacts:[[String:String]] = [
    ]
    
    var filtered:[[String:String]] = [
    ]
    
    public init() {
        refetchData()
    }
    
    func Count() -> Int {
        return contacts.count
    }
    
    func filteredCount() -> Int {
        return filtered.count
    }
    
    func filter(search: String) {
        var result: [[String:String]] = []
        if search.isEmpty {
            filtered = contacts
            contactsViewDelegate?.reloadData()
            return
        }
        for contact in contacts {
            if contact["name"]!.contains(search) {
                result.append(contact)
            }
        }
        if !result.isEmpty {
            filtered = result
        }
        contactsViewDelegate?.reloadData()
    }
    
    func GetContact(index: Int) -> Dictionary<String, String> {
        return contacts[index]
    }
    
    func filteredContact(index: Int) -> Dictionary<String, String> {
        return filtered[index]
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
