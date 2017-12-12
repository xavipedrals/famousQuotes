//
//  Quote.swift
//  famousQuotes
//
//  Created by Xavier Pedrals on 12/12/2017.
//  Copyright © 2017 Xavier Pedrals. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Quote: ParseableObj {
    
    var id: String?
    var likeCount: Int?
    var authorName: String?
    var authorPhoto: String?
    var text: String?
    var backgroundImg: String?
    var backgroundColor: String?
    
    init(from json: JSON) {
        let parser = SafeJSONParser(className: String(describing: Quote.self), json: json)
        
        self.id = parser.getString(index: "_id")
        self.authorName = parser.getString(index: "author_name")
        self.authorPhoto = parser.getString(index: "author_photo")
        self.text = parser.getString(index: "text")
        self.backgroundImg = parser.getString(index: "background_img")
        self.backgroundColor = parser.getString(index: "background_color")
        self.likeCount = parser.getInt(index: "like_count")
    }    
}
