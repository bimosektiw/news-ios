//
//  Articles.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 14/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation

struct Articles: Decodable {
    var status: String?
    var totalResults: Int?
    var articles: [ArticleNews] = []
}

struct ArticleNews: Decodable{
    var author: String?
    var title: String?
    var urlToImage: String?
    var description: String?
}
