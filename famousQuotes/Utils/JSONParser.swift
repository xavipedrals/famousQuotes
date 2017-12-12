//
//  JSONParser.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ParseableObj {
    init(from: JSON)
}

class SafeJSONParser {
    var className: String
    var json: JSON
    
    private enum ParsingError: Error {
        case notString(className: String, index: String)
        case notInt(className: String, index: String)
        case notDouble(className: String, index: String)
        case notBoolean(className: String, index: String)
        case notArray(className: String, index: String)
        case notJSON(className: String, index: String)
    }
    
    init(className: String, json: JSON) {
        guard json.array == nil else {
            fatalError("SafeJSON parser is for parsing single objects, not arrays")
        }
        self.className = className
        self.json = json
    }
    
    func getString(index: String) -> String {
        if let string = json[index].string {
            return string
        }
        print(ParsingError.notString(className: className, index: index))
        return ""
    }
    
    func getInt(index: String) -> Int {
        if let integer = json[index].int {
            return integer
        }
        print(ParsingError.notInt(className: className, index: index))
        return 0
    }
    
    func getDouble(index: String) -> Double {
        if let integer = json[index].double {
            return integer
        }
        print(ParsingError.notDouble(className: className, index: index))
        return 0
    }
    
    func getBoolean(index: String) -> Bool {
        if let integer = json[index].bool {
            return integer
        }
        print(ParsingError.notBoolean(className: className, index: index))
        return false
    }
}
