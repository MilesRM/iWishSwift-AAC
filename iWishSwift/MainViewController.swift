//
//  ViewController.swift
//  iWishSwift
//
//  Created by andycheng on 2016/10/23.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CollectionViewCell"

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var mainLabels = ["溝通","活動(日記)","常用句","自我介紹(回答)","是不是(選擇)","文章"]

    @IBOutlet var MainCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.MainCollectionView.delegate = self
        self.MainCollectionView.dataSource = self
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.MainCollectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        cell.label.text = mainLabels[indexPath.row]
                
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mainLabels.count;
    }
    
    // set cell size
    // must set UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize: CGFloat = self.view.frame.size.width / 2 - 5
        
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
    }
    

}
