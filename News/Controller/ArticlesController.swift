//
//  ArticlesController.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 14/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SDWebImage

class ArticlesController: UIViewController, CoreApiDelegate, UISearchResultsUpdating {
    
    @IBOutlet weak var articleCollection: UICollectionView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var articlesData = Articles()
    var article: [ArticleNews] = []
    let articleViewId = "ArticleView"
    var articleId: String!
    var articleName: String = ""
    let articleApi = ArticleApi()
    var searchResults : [ArticleNews] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: articleViewId, bundle: nil)
        articleCollection.register(nibName, forCellWithReuseIdentifier: articleViewId)
        
        articleApi.delegate = self
        articleApi.source = self.articleId
        articleApi.start()
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        self.navigationItem.titleView = searchController.searchBar
        searchController.searchBar.placeholder = "Search article from \(articleName)"
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func filterContent(for searchText: String) {
        // Update the searchResults array with matches
        // in our entries based on the title value.
        searchResults = articlesData.articles.filter({(x: ArticleNews) -> Bool in
            let match = x.title?.range(of: searchText, options: .caseInsensitive)
            
            return match != nil
        })
    }
    
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do{
            self.articlesData = try JSONDecoder().decode(Articles.self, from: data)
            self.articleCollection.reloadData()
        }catch{}
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            // Reload the table view with the search result data.
            articleCollection.reloadData()
        }
    }
    
}

extension ArticlesController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchController.isActive ? searchResults.count : articlesData.articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = articleCollection.dequeueReusableCell(withReuseIdentifier: articleViewId, for: indexPath) as! ArticleView
        let data = searchController.isActive ? searchResults[indexPath.row] : articlesData.articles[indexPath.row]
        
        cell.articleTitle.text = data.title
        cell.articleDesc.text = data.description
        let imageUrl = URL(string: data.urlToImage ?? "")
        cell.articleImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "image1"), options: .highPriority, completed: nil)
        cell.setDefaultShadow(cornerRadius: 6)
        
        return cell
    }
    
    
}

extension ArticlesController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 15
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 250)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}
