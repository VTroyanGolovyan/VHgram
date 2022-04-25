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
            if !followers.isEmpty {
                pollingRequest()
            }
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                PollingWorker.runPolling()
            }
        } 
    }
    
    public static func pollingRequest() {
        NetworkLayer.sendAuthorizedPOSTRequest(module: "events", getParams: [:], body: [:], complition: eventPerformer)
    }
    
    public static func eventPerformer(events: Any) {
        if let eventsArray = (events as? [[String:Any]])?.getStringsDictArray() {
            for event in eventsArray {
                if let e_type = event["type"] {
                    if let list = followers[e_type] {
                        for follower in list {
                            follower.eventHandle(event: event)
                        }
                    }
                }
            }
        }
    }
    
    public static func followEventByType(e_type: EventType, follower: EventFollower) {
        if followers.keys.contains(e_type.rawValue) {
            followers[e_type.rawValue]?.append(follower)
        } else {
            followers[e_type.rawValue] = [follower]
        }
    }
    
    public static func unfollowEvents(e_type: EventType) {
        if followers.keys.contains(e_type.rawValue) {
            followers.removeValue(forKey: e_type.rawValue)
        }
    }
}


