//
//  HomeHeaderCell.swift
//  SimpleCost
//
//  Created by joe on 2016/10/25.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit
private let identifier = "HomeHeaderCell"
class HomeHeaderCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    var model: HomeModel?{
        didSet{
            let timestamp = NSDate().timeIntervalSince1970
            let orderNumber = Int(timestamp / 60 / 60 / 24)
            let timeContent: String?
            if orderNumber == model?.orderNumber {
                timeContent = "今天"
            }else if ((model?.orderNumber)! - orderNumber ) == 1{
                timeContent = "昨天"
            }else{
                timeContent = timeStampToString(timeStamp: "\(timestamp)") + "日"
            }
            timeLabel.text = timeContent!
            var sum: Float = 0
            for costModel in (model?.costModelArray)! {
                sum = sum + costModel.value!
            }
            costLabel.text = "支出 \(sum)"
        }
    }
    private func timeStampToString(timeStamp: String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="dd"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return dfmatter.string(from: date as Date)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        timeLabel.textColor = UIColor.white
        timeLabel.layer.cornerRadius = 12.5
        timeLabel.clipsToBounds = true
        costLabel.textColor = UIColor.white
    }
    
    class func cellWithTableView(tableView: UITableView) -> HomeHeaderCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if cell == nil {
            cell = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.last as? UITableViewCell
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        return cell! as! HomeHeaderCell
    }
    
}
