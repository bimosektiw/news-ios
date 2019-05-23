//
//  Extensions.swift
//  News
//
//  Created by Bimo Sekti Wicaksono on 23/05/19.
//  Copyright © 2019 bimosektiw. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func setDefaultShadow(cornerRadius: CGFloat) {
        self.backgroundColor = UIColor.white
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.15
        self.layer.shadowPath = UIBezierPath(rect: self.layer.bounds).cgPath
    }
}
