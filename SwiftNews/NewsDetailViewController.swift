//
//  NewsDetailViewController.swift
//  SwiftNews
//
//  Created by Dsilva on 11/08/19.
//  Copyright © 2019 Dsilva. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var articleImage: UIImageView!
    
    @IBOutlet weak var articleBody: UILabel!
    
    
    var newsArticle: NewsArticle!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    
    }
    
    func setupUI() {
        // Setting the title
        self.navigationItem.title = newsArticle.title
        self.articleBody.text = newsArticle.selfText
        self.articleImage.downloaded(from:newsArticle.urlToImage)
    }
    
    
}
