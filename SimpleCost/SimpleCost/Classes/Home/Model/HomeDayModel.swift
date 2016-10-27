//
//  HomeDayModel.swift
//  SimpleCost
//
//  Created by joe on 2016/10/26.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit
enum TimeType {
    case Year
    case Month
    case Day
}

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
    var costSum: Double! = 0
    
    //是否是第一次使用app, 是的话生成数据
    class func modelArray(value: Double){
        var array = NSKeyedUnarchiver.unarchiveObject(withFile: kHomePath) as? [AnyObject]
        if array == nil {
            array = firstCreateData(value: value)
            NSKeyedArchiver.archiveRootObject(array!, toFile: kHomePath)
        }
//        else{
//            let model = array!.last
//            if !CommonTool.isToDay(oldTimestamp: (model?.timestamp)!) {//最后一条数据不是今天
//                //创建一条新数据
//                let model = createNewDayData()
//                array?.insert(model, at: 0)
//            }
//        }
    }
    
    class func modelArryLoad() -> [AnyObject]{
        var array = NSKeyedUnarchiver.unarchiveObject(withFile: kHomePath) as? [AnyObject]
        if array == nil{
            array = [AnyObject]()
        }
        return array!
    }
    
    //创建一条新的数据
    class func createNewDayData() -> HomeDayModel{
        let model = HomeDayModel()
        let timestamp = NSDate().timeIntervalSince1970
        let orderNumber = Int(timestamp / 60 / 60 / 24)
        
        model.timestamp = timestamp
        model.orderNumber = orderNumber
        //        let costModel = CostModel()
        //        costModel.value = 0
        //        model.costModelArray.append(costModel)
        
        return model
    }
    
    //第一次创建缓存
    class func firstCreateData(value: Double) -> [AnyObject]{
        var array = [AnyObject]()
        let timestamp = NSDate().timeIntervalSince1970
        let timestampStr = "\(timestamp)"
        let dayNo = Int(timestamp / 60 / 60 / 24)
        
//        let yearModel = HomeYearModel()
//        let year = HomeDayModel.timeStampToString(timeStamp: timestampStr, timeType: TimeType.Year) as NSString
//        yearModel.time = year.integerValue
//        
//        let monthModel = HomeMonthModel()
//        let month = HomeDayModel.timeStampToString(timeStamp: timestampStr, timeType: TimeType.Month) as NSString
//        monthModel.time = month.integerValue
        
        let dayModel = HomeDayModel()
        let day = HomeDayModel.timeStampToString(timeStamp: timestampStr, timeType: TimeType.Day) as NSString
        dayModel.time = day.integerValue
        dayModel.orderNumber = dayNo
        dayModel.timestamp = timestamp
//        array.append(yearModel)
//        array.insert(monthModel, at: 0)
        array.insert(dayModel, at: 0)
        
        return array
    }
    
    class func timeStampToString(timeStamp: String, timeType: TimeType)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        let type: String!
        if timeType == TimeType.Year {
            type = "yyyy"
        }else if timeType == TimeType.Month{
            type = "MM"
        }else{
            type = "dd"
        }
        dfmatter.dateFormat = type
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return dfmatter.string(from: date as Date)
    }
    
//    private let kOrderNumber = "orderNumber"
//    private let kTimestamp = "timestamp"
//    private let kTime = "time"
//    private let kIndex = "index"
//    private let kCostSum = "costSum"
    func encode(with aCoder: NSCoder) {
        aCoder.encode(orderNumber, forKey: kOrderNumber)
        aCoder.encode(timestamp, forKey: kTimestamp)
        aCoder.encode(time, forKey: kTime)
        aCoder.encode(index, forKey: kIndex)
        aCoder.encode(costSum, forKey: kCostSum)
//        aCoder.encode(costModelArray, forKey: kCostModelArray)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init()
        orderNumber = aDecoder.decodeObject(forKey: kOrderNumber) as? Int
        timestamp = aDecoder.decodeObject(forKey: kTimestamp) as? Double
        time = aDecoder.decodeObject(forKey: kTime) as? Int
        index = aDecoder.decodeObject(forKey: kIndex) as? Int
        costSum = aDecoder.decodeObject(forKey: kCostSum) as? Double
//        costModelArray = aDecoder.decodeObject(forKey: kCostModelArray) as! [CostModel]
    }
    
    override init() {
        super.init()
    }
}
