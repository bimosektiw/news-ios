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

class ArticlesController: UIViewController, CoreApiDelegate {
    
    @IBOutlet weak var articleCollection: UICollectionView!
    
    var articlesData = Articles()
    var article: [ArticleNews] = []
    let articleViewId = "ArticleView"
    var articleId: String!
    var articleName: String!
    let articleApi = ArticleApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: articleViewId, bundle: nil)
        articleCollection.register(nibName, forCellWithReuseIdentifier: articleViewId)
        self.title = articleName
        
        articleApi.delegate = self
        articleApi.source = self.articleId
        articleApi.start()
    }
    
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do{
            self.articlesData = try JSONDecoder().decode(Articles.self, from: data)
            self.articleCollection.reloadData()
        }catch{}
    }
}

extension ArticlesController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articlesData.articles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = articleCollection.dequeueReusableCell(withReuseIdentifier: articleViewId, for: indexPath) as! ArticleView
        let data = articlesData.articles?[indexPath.row]
        cell.articleTitle.text = data?.title
        cell.articleDesc.text = data?.description
        let imageUrl = URL(string: data?.urlToImage ?? "")
        cell.articleImage.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "image1"), options: .highPriority, completed: nil)
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.lightGray.cgColor
        return cell
    }
    
    
}

extension ArticlesController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 15
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: 250)
    }
}
