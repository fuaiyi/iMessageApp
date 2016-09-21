//
//  ItemTableViewCell.swift
//  iMessage
//
//  Created by gaofu on 16/9/20.
//  Copyright © 2016年 gaofu. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    var itemName : String?
        {
        didSet
        {
            guard let itemName = itemName else { return }
            itemImage.image = UIImage(named: itemName)
        }
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        
        
    }
    
    
}
