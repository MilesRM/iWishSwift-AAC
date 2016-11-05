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

    let mainLabels = Constants.mainLabels
    let mainKeys = Constants.mainKeys
    
    var tts:TextToSpeech!
    
    @IBOutlet var MainCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.MainCollectionView.delegate = self
        self.MainCollectionView.dataSource = self
        
        tts = TextToSpeech()
 
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
    
        let nbCol = 2
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        
        return CGSize(width: size, height: 220)
        
    
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
        tts.speak(mainLabels[indexPath.row])
        
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
        
        if segue.identifier == "category" //aac
        {
            if let destViewController = segue.destination as? CategoryViewController {
                destViewController.label = mainLabels[(indexPath?.row)!]
                destViewController.key = mainKeys[(indexPath?.row)!]
            }
        }
        
        
    }


    
   }
