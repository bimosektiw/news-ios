//
//  Constants.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 13/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation

struct Constants{
    static let server = "https://newsapi.org/v2/"
}

struct ConstantsApi{
    static let SOURCES = "sources"
    static let EVERYTHING = "everything"
}

public func server(with api: String) -> String {
    let serverURL = "\(Constants.server)\(api)"
    return serverURL
}
