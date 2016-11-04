//
//  CategoryViewController.swift
//  iWishSwift
//
//  Created by andycheng on 2016/10/23.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "cell"

class CategoryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var switchButton: UISwitch!

    //var categoryLabels = ["1","2","3","4","5","6","7","8","9","10","11","12"]

    let realmCategory = RealmCategory()
    var categoryItems:Results<Category>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        //addButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var fromMain = "";
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.title = fromMain

        categoryItems = realmCategory.SelectAll_Category()
        
        //print(fromMain)
    }

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TextCell
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        
        //print(categoryLabels[indexPath.row])
        
        cell.label.text = categoryItems![indexPath.row].name
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryItems.count;
    }
    
    // set cell size
    // must set UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nbCol = 4
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
      //  performSegue(withIdentifier:"category", sender: self)
        
    }

  

}
