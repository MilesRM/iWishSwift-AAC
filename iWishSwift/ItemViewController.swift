//
//  ItemViewController.swift
//  iWishSwift
//
//  Created by andycheng on 2016/11/4.
//  Copyright © 2016年 ccjeng. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "cell"

class ItemViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var addButton: UIButton!

    let realmItem = RealmItem()
    var items:Results<Item>!
    
    var editMode:Bool = false
    var tts:TextToSpeech!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        tts = TextToSpeech()
        addButton.isHidden = true
    }

    var label = ""
    var key = ""
    var mainKey = ""
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = label
        mainKey = key
        items = realmItem.selectAll()
    }
    
    @IBAction func swithChanged(_ sender: UISwitch) {
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
        
        let cancelAction = UIAlertAction(
            title: "取消",
            style: .cancel,
            handler: nil)
        addAlertController.addAction(cancelAction)
        
        let saveAction = UIAlertAction(title: "儲存", style: .default) {
            (action: UIAlertAction!) -> Void in
            let textField = (addAlertController.textFields?.first!)! as UITextField        
            self.realmItem.add(textField.text!)
        
            self.collectionView?.reloadData()
        }
        addAlertController.addAction(saveAction)
        
        if editMode {
            self.present(addAlertController, animated: true, completion: nil)
        }

    }

    func editData(_ id:String, _ name:String){
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
            self.realmItem.update(id, textField.text!)
            self.collectionView?.reloadData()
        }
        editAlertController.addAction(editAction)
        
        
        let deleteAction = UIAlertAction(title: "刪除", style: .destructive) {
            (action: UIAlertAction!) -> Void in
            
            self.realmItem.delete(id)
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
        
        cell.label.text = items![indexPath.row].name
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count;
    }
    
    // set cell size
    // must set UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let nbCol = 4
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: 220)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var idName:String!
        var labelName:String!
        
        idName = items![indexPath.row].id
        labelName = items![indexPath.row].name
        
        if editMode {
            editData(idName, labelName)
        } else {
            tts.speak(label + labelName)
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
    
    func getIndexPathForSelectedCell() -> IndexPath? {
        
        var indexPath:IndexPath?
        
        if collectionView.indexPathsForSelectedItems!.count > 0 {
            indexPath = collectionView.indexPathsForSelectedItems![0]
        }
        return indexPath
    }
    
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "subitem" {
            if editMode == false{
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let indexPath = getIndexPathForSelectedCell()
            
            if segue.identifier == "subitem" {
                if let destViewController = segue.destination as? SubItemViewController {
                    destViewController.label = label + items![(indexPath?.row)!].name
                    destViewController.key = items![(indexPath?.row)!].id
                }
            }
            
        
    }

}
