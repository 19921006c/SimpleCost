//
//  CommonTool.swift
//  SimpleCost
//
//  Created by joe on 2016/10/19.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

//MARK: 常用尺寸宏
let kScreenBounds = UIScreen.main.bounds
let kScreenWidth = kScreenBounds.width
let kScreenHeight = kScreenBounds.height

class CommonTool: NSObject {
    
    // MARK: 判断时间戳是不是今天
    class func isToDay(oldTimestamp: Double) -> Bool {
        let timestamp = NSDate().timeIntervalSince1970
        
        let orderNumber = Int(timestamp / 60 / 60 / 24)
        let oldOrderNumber = Int(oldTimestamp / 60 / 60 / 24)
        if orderNumber == oldOrderNumber {
            return true
        }else{
            return false
        }
    }
}
