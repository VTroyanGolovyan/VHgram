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
        NetworkLayer.sendAuthorizedPOSTRequest(module: "find", getParams: [:], body: ["text":search], complition: userFindCallback)
    }
    
    func GetContact(index: Int) -> Dictionary<String, String> {
        return contacts[index]
    }
    
    func filteredContact(index: Int) -> Dictionary<String, String> {
        return filtered[index]
    }
    
    func refetchData() {
        NetworkLayer.sendAuthorizedPOSTRequest(module: "contacts", getParams: [:], body: [:], complition: contactsRequestCallback)
    }
    
    private func contactsRequestCallback(response: Any) {
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
