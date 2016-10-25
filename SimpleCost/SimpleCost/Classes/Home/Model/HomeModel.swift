//
//  HomeModel.swift
//  SimpleCost
//
//  Created by joe on 2016/10/21.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

//获取缓存目录
let kPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
//plist 文件路径
let kHomePath = kPath.appendingPathComponent("HomeModelArray.data")
private let kOrderNumber = "orderNumber"
private let kTimestamp = "timestamp"
private let kCostModelArray = "costModelArray"

class HomeModel: NSObject,NSCoding {
    //从1970年起到今天，天数序号 举例 17098
    var orderNumber: Int?
    //记录时间戳
    var timestamp: Double?
    //
    var costModelArray = [CostModel]()
    
    class func modelArray() -> [HomeModel]{
        var array = NSKeyedUnarchiver.unarchiveObject(withFile: kHomePath) as? [HomeModel]
        if array == nil {
            array = [HomeModel]()
            let model = HomeModel.createNewDayData()
            array?.append(model)
            NSKeyedArchiver.archiveRootObject(array!, toFile: kHomePath)
        }else{
            let model = array!.last
            if !CommonTool.isToDay(oldTimestamp: (model?.timestamp)!) {//最后一条数据不是今天
                //创建一条新数据
                let model = HomeModel.createNewDayData()
                array?.append(model)
            }
        }
        return array!
    }
    
    //创建一条新的数据
    class func createNewDayData() -> HomeModel{
        let model = HomeModel()
        let timestamp = NSDate().timeIntervalSince1970
        let orderNumber = Int(timestamp / 60 / 60 / 24)
        model.timestamp = timestamp
        model.orderNumber = orderNumber
//        let costModel = CostModel()
//        costModel.value = 0
//        model.costModelArray.append(costModel)
        return model
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(orderNumber, forKey: kOrderNumber)
        aCoder.encode(timestamp, forKey: kTimestamp)
        aCoder.encode(costModelArray, forKey: kCostModelArray)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        orderNumber = aDecoder.decodeObject(forKey: kOrderNumber) as? Int
        timestamp = aDecoder.decodeObject(forKey: kTimestamp) as? Double
        costModelArray = aDecoder.decodeObject(forKey: kCostModelArray) as! [CostModel]
    }
    
    override init() {
        super.init()
    }
}
