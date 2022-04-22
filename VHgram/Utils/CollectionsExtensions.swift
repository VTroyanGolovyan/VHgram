//
//  CollectionsExtensions.swift
//  VHgram
//
//  Created by Владислав on 22.04.2022.
//

import Foundation


extension Array where Element == [String:Any] {
    func getStringsDictArray() -> [[String:String]] {
        var resultArrayData: [[String:String]] = []
        for dict in self {
            var new_dict: [String:String] = [:]
            for (key, value) in dict {
                new_dict[key] = value as? String
                if new_dict[key] == nil {
                    new_dict[key] =  String(value as? Int ?? 0)
                }
            }
            resultArrayData.append(new_dict)
        }
        return resultArrayData
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return urlEncode()
        .data(using: .utf8)
    }
    
    func urlEncode() -> String {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
