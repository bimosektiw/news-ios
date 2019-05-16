//
//  ArticleView.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 14/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import UIKit

class ArticleView: UICollectionViewCell {
    
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articleDesc: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
