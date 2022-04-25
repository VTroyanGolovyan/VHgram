//
//  DialogModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation
import UIKit

class DialogModel: EventFollower {
    
    var dialogMessagesDelegate: UITableView?
    var dialogNameDelegate: UILabel?
    
    var dialogName:String = ""
    var messages: [[String:String]] = []
    
    public init() {
        PollingWorker.followEventByType(e_type: EventType.NewMessage, follower: self)
    }
    
    func messagesCnt() -> Int {
        return messages.count
    }
    
    func getMessage(id: Int) -> [String:String] {
        return messages[id]
    }
    
    func sendMessage(text: String) {
        NetworkLayer.sendAuthorizedPOSTRequest(
            module: BackendModules.dialogsController,
            getParams: ["type":"send", "dialog": ApplicationGlobals.activeDialog],
            body: ["message":text],
            complition: sendMsgCallback,
            emptyCallback: true
        )
    }
    
    func refetchData() {
        NetworkLayer.sendAuthorizedPOSTRequest(
            module: BackendModules.getDialog,
            getParams: ["dialog": ApplicationGlobals.activeDialog],
            body: [:],
            complition: dialogsRequestCallback
        )
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
    
    func sendMsgCallback(response: Any) {
        refetchData()
    }
    
    func eventHandle(event: [String : String]) {
        refetchData()
    }
}
