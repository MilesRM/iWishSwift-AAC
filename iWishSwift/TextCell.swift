//
//  TextCell.swift
//  iWishSwift
//
//  Created by andycheng on 2016/10/23.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import UIKit

class TextCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
    }
    
}
