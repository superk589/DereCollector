//
//  AppStore.swift
//  DereCollector
//
//  Created by zzk on 2018/4/12.
//

import Foundation
import SwiftyJSON

final class AppStore {
    
    static let shared = AppStore()
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    private var url = URL(string: "https://itunes.apple.com/jp/lookup?id=1016318735")!
    
    func checkAppVersion(callback: @escaping (String) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                // handle error
            } else if (response as! HTTPURLResponse).statusCode != 200 {
                // handle error
            } else {
                let json = JSON(data!)
                let appVersion = json["results"][0]["version"].stringValue
                callback(appVersion)
            }
        }
        task.resume()
    }
    
}
