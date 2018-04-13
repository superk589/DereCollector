//
//  Config.swift
//  DereCollector
//
//  Created by zzk on 2018/4/12.
//

import Foundation

struct Config: Codable {

    let unityVersion: String
    var resVersion: String { didSet { save() } }
    var gameVersion: String { didSet { save() } }
    let gameVersionInterval: Double
    let resVersionInterval: Double
    let resVersionShellPath: String
    
    static var `default` = Config.load()
    
    func save() {
        let path = "./config.json"
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        if let data = try? encoder.encode(self) {
            try? data.write(to: URL(fileURLWithPath: path))
        }
    }
    
    static func load() -> Config {
        let path = "./config.json"
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("open config.json error")
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let config = try? decoder.decode(Config.self, from: data) else {
            fatalError("decode config.json error")
        }
        
        return config
    }
}
