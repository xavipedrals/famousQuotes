//
//  NetworkController.swift
//  InternetTV
//
//  Created by Xavier Pedrals on 13/10/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AlamofireGetter<T: ParseableObj> {
    
    var url: String
    var indexs: [Any]
    
    init(url: String, indexs: [Any]) {
        self.url = url
        self.indexs = indexs
    }
    
    func get(offset: Int = 0, completion: @escaping (_ objects: [T]) -> Void) {
        Alamofire.request(url).responseJSON { response in
            switch response.result {
            case .success(let data):
                
                let json = self.getJSONFrom(data: data)
                let objects = json.arrayValue
                completion(self.parse(objects))
                
            case .failure(let error):
                
                completion([])
                print("""
                    Request failed:
                    - url -> \(self.url)
                    - error -> \(error))
                    """)
            }
        }
    }
    
    func getJSONFrom(data: Any) -> JSON {
        var json = JSON(data)
        for index in indexs {
            if let index = index as? String {
                json = json[index]
            }
            else if let index = index as? Int {
                json = json[index]
            }
            else {
                fatalError("Error when accessing JSON indexs")
            }
        }
        return json
    }
    
    func parse(_ jsonArray: [JSON]) -> [T] {
        var result = [T]()
        for json in jsonArray {
            let element = T(from: json)
            result.append(element)
        }
        return result
    }
}
