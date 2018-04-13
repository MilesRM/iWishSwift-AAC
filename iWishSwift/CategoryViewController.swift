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
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var switchButton: UISwitch!

    @objc let realmCategory = RealmCategory()
    var categoryItems:Results<Category>!
    
    @objc let realmIntroduce = RealmIntroduce()
    var introduceItems:Results<Introduce>!
    
    @objc let realmSelection = RealmSelection()
    var selectionItems:Results<Selection>!
    
    @objc let realmDaily = RealmDaily()
    var dailyItems:Results<Daily>!
    
    @objc let realmFrequency = RealmFrequency()
    var frequencyItems:Results<Frequency>!
    
    @objc var editMode:Bool = false
    @objc var tts:TextToSpeech!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        tts = TextToSpeech()
        addButton.isHidden = true

    }

    @objc var label = ""
    @objc var key = ""
    @objc var mainKey = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //collectionView?.reloadData()
        
        self.navigationItem.title = label
        mainKey = key
        
        switch(mainKey) {
            case "AAC":
                categoryItems = realmCategory.selectAll()
                break
            case "Introduce":
                introduceItems = realmIntroduce.selectAll()
                break
            case "Selection":
                selectionItems = realmSelection.selectAll()
                break
            case "Daily":
                dailyItems = realmDaily.selectAll()
                break
            case "Frequency":
                frequencyItems = realmFrequency.selectAll()
                break
            default:
                break
        }
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        
        if sender.isOn {
            editMode = true
            addButton.isHidden = false
        } else {
            editMode = false
            addButton.isHidden = true
        }
    }
    
    @IBAction func addButtonTouchDown(_ sender: UIButton) {
    
        let addAlertController = UIAlertController(title: "新增", message: "", preferredStyle: .alert)
        
        addAlertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "內容"
        }
        
        let cancelAction = UIAlertAction( title: "取消", style: .cancel, handler: nil)
        addAlertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "儲存", style: .default) {
                (action: UIAlertAction!) -> Void in
            let textField = (addAlertController.textFields?.first!)! as UITextField
            
            switch(self.mainKey) {
            case "AAC":
                self.realmCategory.add(textField.text!)
                break
            case "Introduce":
                self.realmIntroduce.add(textField.text!)
                break
            case "Selection":
                self.realmSelection.add(textField.text!)
                break
            case "Daily":
                self.realmDaily.add(textField.text!)
                break
            case "Frequency":
                self.realmFrequency.add(textField.text!)
                break
            default:
                break
            }
            
            self.collectionView?.reloadData()
        }
        addAlertController.addAction(saveAction)
        
        if editMode {
            self.present(addAlertController, animated: true, completion: nil)
        }
    }
    
  
    @objc func editData(_ id:String, _ name:String){
        let editAlertController = UIAlertController(title: "修改", message: "", preferredStyle: .alert)
        
        editAlertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "內容"
            textField.text = name
        }
 
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        editAlertController.addAction(cancelAction)
        
        let editAction = UIAlertAction(title: "修改", style: .default) {
            (action: UIAlertAction!) -> Void in
            let textField = (editAlertController.textFields?.first!)! as UITextField
            switch(self.mainKey) {
            case "AAC":
                self.realmCategory.update(id, textField.text!)
                break
            case "Introduce":
                self.realmIntroduce.update(id, textField.text!)
                break
            case "Selection":
                self.realmSelection.update(id, textField.text!)
                break
            case "Daily":
                self.realmDaily.update(id, textField.text!)
                break
            case "Frequency":
                self.realmFrequency.update(id, textField.text!)
            default:
                break
            }

            self.collectionView?.reloadData()
        }
        editAlertController.addAction(editAction)
        
        
        let deleteAction = UIAlertAction(title: "刪除", style: .destructive) {
            (action: UIAlertAction!) -> Void in
            switch(self.mainKey) {
            case "AAC":
                self.realmCategory.delete(id)
                break
            case "Introduce":
                self.realmIntroduce.delete(id)
                break
            case "Selection":
                self.realmSelection.delete(id)
                break
            case "Daily":
                self.realmDaily.delete(id)
                break
            case "Frequency":
                self.realmFrequency.delete(id)
                break
            default:
                break
            }
            self.collectionView?.reloadData()
        }
        editAlertController.addAction(deleteAction)
        
        self.present(editAlertController, animated: true, completion: nil)

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! TextCell
        
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
        
        var lableName:String!
        switch(self.mainKey) {
        case "AAC":
            lableName = categoryItems![indexPath.row].name
            break
        case "Introduce":
            lableName = introduceItems![indexPath.row].name
            break
        case "Selection":
            lableName = selectionItems![indexPath.row].name
            break
        case "Daily":
            lableName = dailyItems![indexPath.row].name
            break
        case "Frequency":
            lableName = frequencyItems![indexPath.row].name
            break
        default:
            lableName = ""
            break
        }
        
        cell.label.text = lableName
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var cnt = 0
        switch(self.mainKey) {
        case "AAC":
            cnt = categoryItems.count
            break
        case "Introduce":
            cnt = introduceItems.count
            break
        case "Selection":
            cnt = selectionItems.count
            break
        case "Daily":
            cnt = dailyItems.count
            break
        case "Frequency":
            cnt = frequencyItems.count;
            break
        default:
            cnt = 0
            break
        }

        return cnt;
    }
    
    // set cell size
    // must set UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var nbCol = 4
        
        if mainKey == "Daily" {
            nbCol = 1
        }
        
        if mainKey == "Frequency" {
            nbCol = 3
        }
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: 220)
    
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var idName:String!
        var labelName:String!
        switch(self.mainKey) {
        case "AAC":
            idName = categoryItems![indexPath.row].id
            labelName = categoryItems![indexPath.row].name
            break
        case "Introduce":
            idName = introduceItems![indexPath.row].id
            labelName = introduceItems![indexPath.row].name
            break
        case "Selection":
            idName = selectionItems![indexPath.row].id
            labelName = selectionItems![indexPath.row].name
            break
        case "Daily":
            idName = dailyItems![indexPath.row].id
            labelName = dailyItems![indexPath.row].name
            break
        case "Frequency":
            idName = frequencyItems![indexPath.row].id
            labelName = frequencyItems![indexPath.row].name
            break
        default:
            idName = ""
            labelName = ""
            break
        }
        
        if editMode {
            editData(idName, labelName)
        } else {
            tts.speak(labelName)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.yellow
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.cyan
    }
    
    // MARK:- Selected Cell IndexPath
    
    @objc func getIndexPathForSelectedCell() -> IndexPath? {
        
        var indexPath:IndexPath?
        
        if collectionView.indexPathsForSelectedItems!.count > 0 {
            indexPath = collectionView.indexPathsForSelectedItems![0]
        }
        return indexPath
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "item" {
            if mainKey == "AAC" && editMode == false{
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if mainKey == "AAC" {
            let indexPath = getIndexPathForSelectedCell()
        
            if segue.identifier == "item" {
                if let destViewController = segue.destination as? ItemViewController {
                    destViewController.label = categoryItems![(indexPath?.row)!].name
                    destViewController.key = categoryItems![(indexPath?.row)!].id
            }
        }
        
      }
        
    }


  

}
