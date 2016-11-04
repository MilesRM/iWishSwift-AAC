//
//  ItemViewController.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    var label = ""
    var key = ""
    var mainKey = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = label
        mainKey = key
        
    }

}
