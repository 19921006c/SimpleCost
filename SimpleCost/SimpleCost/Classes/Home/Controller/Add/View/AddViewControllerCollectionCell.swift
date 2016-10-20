//
//  AddViewControllerCollectionCell.swift
//  SimpleCost
//
//  Created by joe on 2016/10/20.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

class AddViewControllerCollectionCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    
    var content: String?{
        didSet{
            label.text = content
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
