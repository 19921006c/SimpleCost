//
//  HomeMonthAndYearCell.swift
//  SimpleCost
//
//  Created by joe on 2016/10/26.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit
private let identifier = "HomeMonthAndYearCell"
class HomeMonthAndYearCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func cellWithTableView(tableView: UITableView) -> HomeMonthAndYearCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.last as? UITableViewCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        return cell! as! HomeMonthAndYearCell
    }
    
}
