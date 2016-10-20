//
//  HomeCell.swift
//  SimpleCost
//
//  Created by joe on 2016/10/20.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.textColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
