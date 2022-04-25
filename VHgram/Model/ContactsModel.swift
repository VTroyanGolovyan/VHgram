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
    
    var contactsSet: Set<String> = []
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
        NetworkLayer.sendAuthorizedPOSTRequest(
            module: BackendModules.findUsers,
            getParams: [:],
            body: ["text": search],
            complition: userFindCallback
        )
    }
    
    func GetContact(index: Int) -> Dictionary<String, String> {
        return contacts[index]
    }
    
    func filteredContact(index: Int) -> Dictionary<String, String> {
        return filtered[index]
    }
    
    func refetchData() {
        NetworkLayer.sendAuthorizedPOSTRequest(
            module: BackendModules.getContacts,
            getParams: [:],
            body: [:],
            complition: contactsRequestCallback
        )
    }
    
    func isUserContact(id: String) -> Bool {
        return contactsSet.contains(id)
    }
    
    func addContact(id: String) {
        contactsSet.insert(id)
        NetworkLayer.sendAuthorizedGETRequest(
            module: BackendModules.addContact,
            getParams: ["id":id],
            complition: contactsCallback
        )
    }
    
    func removeContact(id: String) {
        contactsSet.remove(id)
        NetworkLayer.sendAuthorizedGETRequest(
            module: BackendModules.deleteContact,
            getParams: ["id":id],
            complition: contactsCallback
        )
    }
    
    func contactsCallback(response: Any) {
        refetchData()
    }
    
    private func contactsRequestCallback(response: Any) {
        let array = response as? [[String:Any]]
        if let arrayData = array?.getStringsDictArray() {
            contacts = arrayData
            contactsSet = []
            for contact in contacts {
                if let id = contact["id"] {
                    contactsSet.insert(id)
                }
            }
            if contactsViewDelegate != nil {
                DispatchQueue.main.async { [self] in
                    contactsViewDelegate?.reloadData()
                }
            }
        }
    }
    
    private func userFindCallback(response: Any) {
        filtered = []
        let array = response as? [[String:Any]]
        if let arrayData = array?.getStringsDictArray() {
            for user in arrayData {
                filtered.append(user)
            }
            if contactsViewDelegate != nil {
                DispatchQueue.main.async { [self] in
                    contactsViewDelegate?.reloadData()
                }
            }
        }
    }
}
