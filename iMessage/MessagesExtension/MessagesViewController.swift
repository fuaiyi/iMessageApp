//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by gaofu on 16/9/20.
//  Copyright © 2016年 gaofu. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController
{
    
    fileprivate let itemTableViewCellID = "ItemTableViewCell"
    fileprivate let itemCollectionViewCellID = "ItemCollectionViewCell"

    @IBOutlet weak var itemClassTableview: UITableView!
    @IBOutlet weak var itemCollectionView: UICollectionView!
    @IBOutlet weak var itemFlowLayout: UICollectionViewFlowLayout!
    
    
    fileprivate var stickers = [MSSticker]()
    fileprivate var isSelect = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupTableview()
        setupCollectionView()
    
        
    }
    
    private func setupTableview()
    {
        
        let nib = UINib(nibName: itemTableViewCellID, bundle: nil)
        itemClassTableview.register(nib, forCellReuseIdentifier: itemTableViewCellID)
        itemClassTableview.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .top)
        
    }
    
    private func setupCollectionView()
    {
        
        let nib = UINib(nibName: itemCollectionViewCellID, bundle: nil)
        itemCollectionView.register(nib, forCellWithReuseIdentifier: itemCollectionViewCellID)
        let spaace = ( UIScreen.main.bounds.width * 0.8 - (4 + 1) * 10 ) / 4
        itemFlowLayout.itemSize =  CGSize(width: spaace, height: spaace)
        
    }

}

extension MessagesViewController : UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: itemTableViewCellID) as! ItemTableViewCell
        cell.itemName = "\(indexPath.row + 1)_1.gif"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let selectIndexPath = IndexPath(row: 0, section: indexPath.row)
        isSelect = true
        itemCollectionView.selectItem(at: selectIndexPath, animated: true, scrollPosition: .top)
        
    }
    
}

extension MessagesViewController : UICollectionViewDelegate,UICollectionViewDataSource
{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        
        return 8
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return 9
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCollectionViewCellID, for: indexPath) as! ItemCollectionViewCell
        cell.itemImageName = String(indexPath.section + 1) + "_" + String(indexPath.item + 1)
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        
        guard let activeConversation = self.activeConversation else { return }
        
        let url = Bundle.main.url(forResource: String(indexPath.section + 1) + "_" + String(indexPath.item + 1), withExtension: "gif")
        
        do
        {
            let sticker = try MSSticker(contentsOfFileURL: url!, localizedDescription: "")
            activeConversation.insert(sticker, completionHandler: nil)
        }
        catch
        {
            print(error)
        }

    }
 
}


extension MessagesViewController : UIScrollViewDelegate
{
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView)
    {
        
        if scrollView == itemCollectionView
        {
            self.isSelect = false
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
    
        if scrollView == itemCollectionView && !isSelect
        {
            let spaace = ( UIScreen.main.bounds.width * 0.8 - (4 + 1) * 10 ) / 4 + 10
            let index = Int(round(scrollView.contentOffset.y / spaace / 3))
            let indePath = IndexPath(row: max(min(index, 7), 0), section: 0)
            self.itemClassTableview.selectRow(at: indePath, animated: true, scrollPosition: .top)
            self.itemClassTableview.scrollToRow(at: indePath, at: .middle, animated: true)
        }
    
    }
    
}
