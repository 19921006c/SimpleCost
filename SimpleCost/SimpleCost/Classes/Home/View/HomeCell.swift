//
//  HomeCell.swift
//  SimpleCost
//
//  Created by joe on 2016/10/20.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit
private let identifier = "HomeCell"
class HomeCell: UITableViewCell {
    
    var model: CostModel?{
        didSet{
            label.text = "\((model?.title)!) \((model?.value)!)"
        }
    }

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.textColor = UIColor.white
    }

    class func cellWithTableView(tableView: UITableView) -> HomeCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.last as? UITableViewCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        return cell! as! HomeCell
    }
    
}
