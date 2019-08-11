//
//  NewsArticle.swift
//  SwiftNews
//
//  Created by Dsilva on 11/08/19.
//  Copyright © 2019 Dsilva. All rights reserved.
//

import UIKit

class NewsArticle: NSObject {
    
    
    var author: String
    var title: String
    var selfText: String
    var url: String
    var urlToImage: String
    
    init(author: String, title: String, selfText: String, url: String, urlToImage: String) {
        self.author = author
        self.title = title
        self.selfText = selfText
        self.url = url
        self.urlToImage = urlToImage
    }
    
    
    
    // Init the object with JSON // Parsing done here
    init?(json: [String: Any]) {
        
        if let author = json["author"] as? String {
            self.author = author
        }else {
            self.author = ""
        }
        if let title = json["title"] as? String {
            self.title = title
        }else {
            self.title = ""
        }
        if let selfText = json["selftext"] as? String {
            self.selfText = selfText
        }else {
            self.selfText = ""
        }
        if let url = json["url"] as? String {
            self.url = url
        }else {
            self.url = ""
        }
        if let sourceDict = json["preview"] as? [String:Any],
            let images = sourceDict["images"] as? [String:Any],
            let source = images["source"] as? [String:Any],
            let urlToImage = source["url"] as? String {
            
                self.urlToImage = urlToImage
        }else {
            urlToImage = ""
        }
        
    }
    
}
