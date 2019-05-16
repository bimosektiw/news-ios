//
//  ArticleApi.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 15/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation

class ArticleApi: CoreApi{
    
    var source = ""
    
    override init() {
        super.init()
        self.URL = server(with: ConstantsApi.EVERYTHING)
        self.method = .get
    }
    
    func start(){
        getRequest()
    }
    
    override func getParam() -> [String : Any] {
        let parameters: [String : Any] = [ArticleApiConst.source : source]
        
        return parameters
    }
}

struct ArticleApiConst{
    static let source = "sources"
}
