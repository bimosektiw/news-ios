//
//  Sources.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 14/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation

struct Sources: Decodable{
    var status: String?
    var sources: [SourceNews]?
}

struct SourceNews: Decodable {
    var id: String?
    var name: String?
    var description: String?
    var url: String?
    var category: String?
    var language: String?
    var country: String?
}
