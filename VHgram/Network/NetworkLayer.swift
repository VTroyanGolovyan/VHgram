//
//  NetworkLayer.swift
//  VHgram
//
//  Created by Владислав on 19.04.2022.
//

import Foundation
import UIKit

class NetworkLayer {

    public static var baseServerURL: String = "http://194.87.236.128/VHchat-Server/server/";
    public static var baseImageServerURL: String = "http://194.87.236.128/VHchat-Server/image_server/";
    
    static func sendPOSTRequest(module: String, getParams: Dictionary<String, Any>, body: Dictionary<String, Any>, complition: @escaping (Any?)->()) {
        let url = URL(string: baseServerURL + "?module=" + module + "&" + getParams.urlEncode())!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
        request.httpBody = body.percentEncoded()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {
                print("error", error ?? "Unknown error")
                return
            }

            guard (200 ... 299) ~= response.statusCode else {
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            if !data.isEmpty {
                let responseString = String(data: data, encoding: .utf8)
                let dataDict = serialize(text: responseString!)
                complition(dataDict)
            }
            
            
        }
        task.resume()
    }
    
    static func sendAuthorizedPOSTRequest(module: String, getParams: Dictionary<String, Any>, body: Dictionary<String, Any>, complition: @escaping (Any?)->()) {
        var params = getParams
        params["hash"] = AuthModel.GetInstance().token
        NetworkLayer.sendPOSTRequest(
            module: module,
            getParams: params,
            body: body, complition: complition)
    }
    
    static func loadImage(relativePath: String, img: UIImageView) {
        let urlString = baseServerURL + relativePath
        let url = URL(string: urlString)
        createNeedFolders()
        DispatchQueue.global().async {
            if let image = retrieveImage(forKey: relativePath) {
                DispatchQueue.main.async {
                    img.image = image
                }
                
                return
            }
            let data = try? Data(contentsOf: url!)
            if let goodData = data {
                DispatchQueue.main.async {
                    img.image = UIImage(data: goodData)
                }
                if let toStore = UIImage(data: goodData) {
                    store(image: toStore, forKey: relativePath)
                }
            }
           
        }
    }
    
    static func serialize(text: String) -> Any? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: [])
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    static private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    static private func store(image: UIImage,
                                      forKey key: String) {
        if let pngRepresentation = image.pngData() {
              if let filePath = filePath(forKey: key) {
                  try? pngRepresentation.write(to: filePath,
                                              options: .atomic)
              }
        }
     }
    
    static private func retrieveImage(forKey key: String) -> UIImage? {
          if let filePath = self.filePath(forKey: key),
              let fileData = FileManager.default.contents(atPath: filePath.path),
              let image = UIImage(data: fileData) {
              return image
          }
          return nil
     }
    
    static private func createNeedFolders() {
        createFolderIfNotExists(folder: "avatars")
        createFolderIfNotExists(folder: "dialogs_imgs")
    }
    
    static private func createFolderIfNotExists(folder: String) {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return }
        
        let dataPath = documentURL.appendingPathComponent(folder)
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try FileManager.default.createDirectory(atPath: dataPath.path, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
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
