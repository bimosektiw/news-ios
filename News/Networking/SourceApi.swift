//
//  SourceApi.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 13/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation
class SourceApi: CoreApi {
    override init() {
        super.init()
        self.URL = server(with: ConstantsApi.SOURCES)
        self.method = .get
    }
    
    func start(){
        getRequest()
    }
}
