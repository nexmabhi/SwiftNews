//
//  APIHelper.swift
//  SwiftNews
//
//  Created by Dsilva on 11/08/19.
//  Copyright © 2019 Dsilva. All rights reserved.
//

import UIKit

class APIHelper: NSObject {
    
    // This class keeps track of the page and fetching logic and only gives the filtered, "ONLY data" to the ViewModelClass class
    
    // Statefull
    override init() {}
    static let shared = APIHelper()
    
    
    // Get first entry of the list
    func getFirstArticleFromAPIWithSearchTerm(_ completion: @escaping (_ newsArticles:[NewsArticle]?, _ error:Error?, _ articlesFound: Bool) -> () ) {
        
        var news = [NewsArticle]()
        var articleFound = false
        var url = URLComponents(string: "https://www.reddit.com/r/swift/.json")!
        
        url.percentEncodedQuery = url.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: url.url!)
        
        let task = URLSession.shared.dataTask(with: request) { (data, getResponse, error) in
            guard let data = data,                            // is there data
                let response = getResponse as? HTTPURLResponse,  // is there HTTP response
                (200 ..< 300) ~= response.statusCode,         // is statusCode 2XX
                error == nil else {                           // was there no error, otherwise ...
                    completion(nil, error, false)
                    return
            }
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data)
                if let dictionary = jsonObject as? [String: Any],
                    let dataArr = dictionary["data"] as? [String: Any],
                    let children = dataArr["children"] as? [[String: Any]] {
                    for child in children {
                        guard let childData = child["data"] as? [String: Any] else {
                            continue
                        }
                        let article = NewsArticle.init(json: childData)
                        if let newsArticle = article {
                            news.append(newsArticle)
                        }
                        debugPrint("title is \(child["title"])")
                    }
                    if news.count > 0 {
                        completion(news, nil, true)
                    }
                    else {
                        // No articles were
                        completion(nil, nil, false)
                    }
                }
            } catch {
                print("JSONSerialization error:", error)
                completion(nil, error, false)
                return
            }
        }
        task.resume()
        
    }
}
