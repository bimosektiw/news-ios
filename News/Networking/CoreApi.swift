//
//  CoreApi.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 13/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

@objc protocol CoreApiDelegate {
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data)
    @objc optional func failed(interface: CoreApi, result: AnyObject)
}

class CoreApi: NSObject{
    let apiKey = "c6eded46100e4bcfabd1890750d17250"
    var URL = ""
    var method: HTTPMethod = .get
    var delegate: CoreApiDelegate?
    var isAuthorization = true
    
    func getRequest(){
        print("\(URL)")
        Alamofire.request(URL, method: self.method, parameters: self.getParam(), headers: self.getHeader()).responseJSON{response in
            if self.isConnectedToInternet() {
                let statusCode = response.response?.statusCode
                switch (statusCode) {
                    
                case 200,201,204,409:
                    guard let responseHeader = response.response else { return }
                    guard let data = response.data else { return }
                    self.success(responseHeaders: responseHeader, data: data)
                    
                case 400,404:
                    self.failed(data: response.result.value as AnyObject)
                    
                case 500:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationHandleServerDown"), object: nil)
                    
                default:
                    if let error = response.result.error {
                        if error._code == NSURLErrorTimedOut {
                            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationHandleConnection"), object: nil, userInfo: ["message": "Koneksi gagal. Coba lagi"])
                        }
                    }
                }
            } else {
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationHandleConnection"), object: nil, userInfo: ["message": "Koneksi internet Anda terputus"])
            }
        }
    }
    
    func getHeader() -> HTTPHeaders{
        var headers = ["Content-type" : "application/json"]
        if isAuthorization{
            headers.updateValue("Bearer \(apiKey)", forKey: "Authorization")
        }
        return headers
    }
    
    func getParam() -> [String: Any]{
        return [:]
    }
    
    func success(responseHeaders: HTTPURLResponse, data: Data){
        delegate?.finish(interFace: self, responseHeaders: responseHeaders, data: data)
    }
    
    func failed(data: AnyObject){
        delegate?.failed!(interface: self, result: data)
    }
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
