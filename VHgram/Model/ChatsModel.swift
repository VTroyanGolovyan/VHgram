//
//  ChatsModel.swift
//  VHgram
//
//  Created by Владислав on 13.04.2022.
//

import Foundation

class ChatsModel {
    var chats = [
        ["name": "Vladislav Troyan",
         "last": "Hello, friend",
         "date": "30.10.2022 18:00",
         "new":"3"],
        ["name": "Vitaliy Memesovich",
         "last": "Goodbye, friend",
         "date": "30.10.2022 18:00",
         "new":"1"],
        ["name": "Vladislav Troyan",
         "last": "Lol kek cheburek",
         "date": "30.10.2022 18:00",
         "new":"3"],
        ["name": "Valentin strykalo",
         "last": "Hello, friend",
         "date": "30.10.2022 18:00",
         "new":"3"],
        ["name": "Vladislav Troyan",
         "last": "Hello, friend",
         "date": "30.10.2022 18:00",
         "new":"2"],
        ["name": "Vladislav Troyan",
         "last": "Hello, friend",
         "date": "30.10.2022 18:00",
         "new":"3"],
        ["name": "Vladislav Troyan",
         "last": "Hello, friend",
         "date": "30.10.2022 18:00",
         "new":"5"],
        ["name": "Vladislav Troyan",
         "last": "MAMAMA, friend",
         "date": "30.10.2022 18:00",
         "new":"3"]
    ]
    
    func Count() -> Int {
        return chats.count
    }
    
    func GetChat(index: Int) -> Dictionary<String, String> {
        return chats[index]
    }
}
