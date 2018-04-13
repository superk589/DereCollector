//
//  main.swift
//  DereCollector
//
//  Created by zzk on 2018/4/11.
//

import PerfectHTTP
import PerfectHTTPServer
import PerfectSQLite
import PerfectRepeater
import PerfectLib
import Foundation
import Timepiece
import SwiftShell

// An example request handler.
// This 'handler' function can be referenced directly in the configuration below.
func handler(request: HTTPRequest, response: HTTPResponse) {
    // Respond with a simple message.
    response.setHeader(.contentType, value: "text/html")
    response.appendBody(string: "<html><title>Hello, world!</title><body>Hello, world!</body></html>")
    // Ensure that response.completed() is called when your processing is done.
    response.completed()
}

let dbPath = "./database"

if !FileManager.default.fileExists(atPath: dbPath) {
    FileManager.default.createFile(atPath: dbPath, contents: nil, attributes: nil)
}

do {
    let sqlite = try SQLite(dbPath)
    defer {
        sqlite.close() // This makes sure we close our connection.
    }
    try sqlite.execute(statement: """
        CREATE TABLE IF NOT EXISTS event_ranking (
            "id" integer PRIMARY KEY AUTOINCREMENT,
            "event_id" integer,
            "border" integer,
            "creat_time" text,
            "request_time" text,
            "rank_type" integer,
            "point" integer
        );
    """)
} catch {
        //Handle Errors
}

func requestRankingData() {
    
}

// update game version
Repeater.exec(timer: Config.default.gameVersionInterval) { () -> Bool in
    Log.info(message: "begin checking game version...")
    AppStore.shared.checkAppVersion(callback: { appVersion in
        Log.info(message: "current game version is \(Config.default.gameVersion)")
        Log.info(message: "App Store game version is \(appVersion)")
        Config.default.gameVersion = appVersion
    })
    return true
}

// update res version
Repeater.exec(timer: Config.default.resVersionInterval) { () -> Bool in
    Log.info(message: "begin checking res version...")
    APIClient.shared.checkResVersion(callback: { resVersion in
        Log.info(message: "current res version is \(Config.default.resVersion)")
        Log.info(message: "neweset res version is \(resVersion)")
        if Config.default.resVersion < resVersion {
            Log.info(message: "run script at \(Config.default.resVersionShellPath)")
            Config.default.resVersion = resVersion
            print(SwiftShell.runAsync(bash: Config.default.resVersionShellPath).stdout)
        }
    })
    return true
}

Repeater.exec(timer: 60) { () -> Bool in
    
    let current = Date()
    if current.minute % 15 == 2 {
        requestRankingData()
    } else {
        
    }
    do {
        let sqlite = try SQLite(dbPath)
        defer {
            sqlite.close() // This makes sure we close our connection.
        }
        
        
    } catch {
        //Handle Errors
    }
    
    return true
}

// Configuration data for an example server.
// This example configuration shows how to launch a server
// using a configuration dictionary.

let confData = [
    "servers": [
        // Configuration data for one server which:
        //    * Serves the hello world message at <host>:<port>/
        //    * Serves static files out of the "./webroot"
        //        directory (which must be located in the current working directory).
        //    * Performs content compression on outgoing data when appropriate.
        [
            "name":"localhost",
            "port":8181,
            "routes":[
                ["method":"get", "uri":"/", "handler":handler],
                ["method":"get", "uri":"/**", "handler":PerfectHTTPServer.HTTPHandler.staticFiles,
                 "documentRoot":"./webroot",
                 "allowResponseFilters":true]
            ],
            "filters":[
                [
                    "type":"response",
                    "priority":"high",
                    "name":PerfectHTTPServer.HTTPFilter.contentCompression,
                    ]
            ]
        ]
    ]
]

do {
    // Launch the servers based on the configuration data.
    try HTTPServer.launch(configurationData: confData)
} catch {
    fatalError("\(error)") // fatal error launching one of the servers
}
