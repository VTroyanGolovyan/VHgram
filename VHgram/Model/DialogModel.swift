//
//  DialogModel.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation

class DialogModel {
    var dialogName:String = ""
    
    func refetchData() {
        NetworkLayer.sendAuthorizedPOSTRequest(module: "getdialog", getParams: ["dialog":ApplicationGlobals.activeDialog], body: [:], complition: dialogsRequestCallback)
    }
    
    private func dialogsRequestCallback(response: Any) {
        
        let array = response as? [String:Any]
        print(array)
        
    }
}
