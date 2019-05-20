//
//  ViewController.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 13/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, CoreApiDelegate {
    
    @IBOutlet weak var sourceTable: UITableView!
    
    let sourceViewId = "SourceView"
    var sourceData = Sources()
    let sourcesApi = SourceApi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibName = UINib(nibName: sourceViewId, bundle: nil)
        sourceTable.register(nibName, forCellReuseIdentifier: sourceViewId)
        
        sourcesApi.delegate = self
        sourcesApi.start()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func finish(interFace: CoreApi, responseHeaders: HTTPURLResponse, data: Data) {
        do{
            self.sourceData = try JSONDecoder().decode(Sources.self, from: data)
            self.sourceTable.reloadData()
        }catch{
            
        }
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "listArticleVC") as! ArticlesController
        let data = sourceData.sources?[indexPath.row]
        vc.articleId = data?.id ?? ""
        vc.articleName = data?.name ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.sources?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = sourceTable.dequeueReusableCell(withIdentifier: sourceViewId, for: indexPath) as! SourceView
        let data = sourceData.sources?[indexPath.row]
        cell.title.text = data?.name
        return cell
    }
    
    
}
