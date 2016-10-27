//
//  HomeDayModel.swift
//  SimpleCost
//
//  Created by joe on 2016/10/26.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

//获取缓存目录
let kPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
//plist 文件路径
let kHomePath = kPath.appendingPathComponent("HomeModelArray.data")
private let kOrderNumber = "orderNumber"
private let kTimestamp = "timestamp"
private let kTime = "time"
private let kIndex = "index"
private let kCostSum = "costSum"
class HomeDayModel: NSObject, NSCoding {
    //几号
    var time: Int?
    //数据队列中的次序
    var index: Int?
    //从1970年起到今天，天数序号 举例 17098
    var orderNumber: Int?
    //记录时间戳
    var timestamp: Double?
    //消费model数组
    var cost = [CostModel]()
    //当天消费合计
    var costSum: Double! = 0
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(orderNumber, forKey: kOrderNumber)
        aCoder.encode(timestamp, forKey: kTimestamp)
        aCoder.encode(time, forKey: kTime)
        aCoder.encode(index, forKey: kIndex)
        aCoder.encode(costSum, forKey: kCostSum)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        orderNumber = aDecoder.decodeObject(forKey: kOrderNumber) as? Int
        timestamp = aDecoder.decodeObject(forKey: kTimestamp) as? Double
        time = aDecoder.decodeObject(forKey: kTime) as? Int
        index = aDecoder.decodeObject(forKey: kIndex) as? Int
        costSum = aDecoder.decodeObject(forKey: kCostSum) as? Double
    }
    
    override init() {
        super.init()
    }
}
