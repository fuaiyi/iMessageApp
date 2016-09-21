//
//  ItemCollectionViewCell.swift
//  iMessage
//
//  Created by gaofu on 16/9/20.
//  Copyright © 2016年 gaofu. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var itemImage: UIWebView!
    
    
    var itemImageName : String?
        {
        didSet{
            
            guard let url = Bundle.main.url(forResource: itemImageName, withExtension: "gif") else { return }
            do
            {
                let data = try Data(contentsOf: url)
                itemImage.load(data, mimeType: "image/gif", textEncodingName: "", baseURL: url)
            }
            catch
            {
            }
            
            
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
    }

}
