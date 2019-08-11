//
//  NewsListViewController.swift
//  SwiftNews
//
//  Created by Dsilva on 11/08/19.
//  Copyright © 2019 Dsilva. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var newsTable: UITableView!
    var articleArr = [NewsArticle]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    func setupUI() {
        
        // Setting the title
        self.navigationItem.title = "Swift News"
        
        //setting tabledelegate
        self.newsTable.delegate = self
        self.newsTable.dataSource = self
        self.newsTable.rowHeight = UITableView.automaticDimension;
        APIHelper.shared.getFirstArticleFromAPIWithSearchTerm { (articleArr, error, ariclesFound) in
            
            guard error == nil else {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            guard ariclesFound == true else {
                let alert = UIAlertController(title: "Error", message: "no article was found", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler:nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            guard articleArr?.count != nil,
                articleArr!.count > 0 else {
                    return
            }
            self.articleArr = articleArr!
            DispatchQueue.main.async {
                self.newsTable.reloadData()
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexpath = sender as? IndexPath else {
            return
        }
        
        let newsDetailScreen = segue.destination as! NewsDetailViewController
        newsDetailScreen.newsArticle = articleArr[indexpath.row]
    }
    
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SNTableViewCellIndentifiers.NEWS_CELL, for: indexPath) as! HomeNewsCell
        
        cell.newsTitle.text = articleArr[indexPath.row].title
        cell.newsImage.downloaded(from:articleArr[indexPath.row].urlToImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "news_details", sender: indexPath)
    }
    
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

