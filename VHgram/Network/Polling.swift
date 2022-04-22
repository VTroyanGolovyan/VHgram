//
//  Polling.swift
//  VHgram
//
//  Created by Владислав on 20.04.2022.
//

import Foundation

enum EventType: String, CaseIterable {
    case NewMessage = "msg";
    case TypingUser = "typing";
}

protocol EventFollower {
    func eventHandle(event: [String:String]);
}

class PollingWorker {
    static var followers: [String: [EventFollower]] = [:]
    
    public static func runPolling() {
        DispatchQueue.global().async {
            pollingRequest()
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                PollingWorker.runPolling()
            }
        } 
    }
    
    public static func pollingRequest() {
        NetworkLayer.sendAuthorizedPOSTRequest(module: "events", getParams: [:], body: [:], complition: eventPerformer)
    }
    
    public static func eventPerformer(events: Any) {
        let eventsArray = events as? [[String:Any]]
        var eventsArrayData: [[String:String]] = []
        for event in eventsArray! {
            var new_dict: [String:String] = [:]
            for (key, value) in event {
                new_dict[key] = value as? String
                if new_dict[key] == nil {
                    new_dict[key] =  String(value as? Int ?? 0)
                }
            }
            eventsArrayData.append(new_dict)
        }
        for event in eventsArrayData {
            if let e_type = event["type"] {
                if let list = followers[e_type] {
                    for follower in list {
                        follower.eventHandle(event: event)
                    }
                }
            }
        }
    }
    
    public static func followEventByType(e_type: EventType,  follower: EventFollower) {
        if followers.keys.contains(e_type.rawValue) {
            followers[e_type.rawValue]?.append(follower)
        } else {
            followers[e_type.rawValue] = [follower]
        }
    }
}
