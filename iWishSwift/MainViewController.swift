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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    //fileprivate let leftAndRightPadding: CGFloat = 32.0
    //fileprivate let numberOfItemsPerRow: CGFloat = 3.0
    //fileprivate let heightAdjustment: CGFloat = 30.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.MainCollectionView.delegate = self
        self.MainCollectionView.dataSource = self
        
        /*
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
 */
        
        /*
        let width = (MainCollectionView!.frame.width - leftAndRightPadding) / numberOfItemsPerRow
        let layout = flowLayout as UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width + heightAdjustment)
        */
        //let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        //self.MainCollectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TextCell

        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        
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
    
        let nbCol = 3
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)
        
    
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        //print(mainLabels[indexPath.row])
    }
    
    // MARK:- Selected Cell IndexPath

    func getIndexPathForSelectedCell() -> IndexPath? {
        
        var indexPath:IndexPath?
        
        if MainCollectionView.indexPathsForSelectedItems!.count > 0 {
            indexPath = MainCollectionView.indexPathsForSelectedItems![0]
        }
        return indexPath
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = getIndexPathForSelectedCell()
        
        if segue.identifier == "category"
        {
            if let destViewController = segue.destination as? CategoryViewController {
                destViewController.fromMain = mainLabels[(indexPath?.row)!]
            }
        }
    }


    
   }
