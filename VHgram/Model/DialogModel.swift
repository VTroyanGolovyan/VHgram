//
//  DialogModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation
import UIKit

class DialogModel {
    
    var dialogMessagesDelegate: UITableView?
    var dialogNameDelegate: UILabel?
    var dialogName:String = ""
    
    var messages: [[String:String]] = []
    
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
        let res = response as? [String:Any]
        dialogName = res?["dialog_name"] as! String
        messages = res?["messages"] as? [[String:String]] ?? []
        DispatchQueue.main.async { [self] in
            dialogNameDelegate?.text = dialogName
            dialogMessagesDelegate?.reloadData()
            if messages.count > 0 {
                let indexPath = IndexPath(row: messages.count - 1, section: 0)
                dialogMessagesDelegate?.scrollToRow(at: indexPath, at: .bottom, animated: true)
                
                
            }
        }
    }
    
}
