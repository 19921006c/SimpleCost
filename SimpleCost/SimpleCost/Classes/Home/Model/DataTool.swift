//
//  DataTool.swift
//  SimpleCost
//
//  Created by joe on 2016/10/27.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

class DataTool: NSObject {
    
    //首页读取数据
    class func modelArryLoad() -> [AnyObject]{
        var array = NSKeyedUnarchiver.unarchiveObject(withFile: kHomePath) as? [AnyObject]
        //缓存为空，创建一个数组返回
        if array == nil{
            array = [AnyObject]()
        }
        return array!
    }
    
    //是否是第一次使用app, 是的话生成数据
    class func modelArray(value: Double){
        var array = NSKeyedUnarchiver.unarchiveObject(withFile: kHomePath) as? [HomeYearModel]
        if array == nil {//是第一次使用app
            //创建数据
            array = firstCreateData(value: value)
            //缓存数据
            DataTool.saveData(array: array!)
        }else{//不是第一次
            
        }
    }
    
    //第一次创建缓存
    class func firstCreateData(value: Double) -> [HomeYearModel]{
        var array = [HomeYearModel]()
        let timestamp = NSDate().timeIntervalSince1970
        let timestampStr = "\(timestamp)"
        let dayNo = Int(timestamp / 60 / 60 / 24)
        
        //创建年model
        let yearModel = HomeYearModel()
        let year = (CommonTool.timeStampToString(timeStamp: timestampStr, timeType: TimeType.Year) as NSString).integerValue
        yearModel.time = year
        array.append(yearModel)
        //创建月模型
        let monthModel = HomeMonthModel()
        let month = (CommonTool.timeStampToString(timeStamp: timestampStr, timeType: TimeType.Month) as NSString).integerValue
        monthModel.time = month
        yearModel.month.append(monthModel)
        //创建日模型
        let dayModel = HomeDayModel()
        let day = (CommonTool.timeStampToString(timeStamp: timestampStr, timeType: TimeType.Day) as NSString).integerValue
        dayModel.time = day
        dayModel.orderNumber = dayNo
        dayModel.timestamp = timestamp
        monthModel.day.append(dayModel)
        //创建消费模型
        let costModel = CostModel()
        costModel.value = value
        dayModel.cost.append(costModel)
        //计算合计
        dayModel.costSum = value
        monthModel.costSum = value
        yearModel.costSum = value
        return array
    }
    
    //添加一条消费数据
    class func addCostData(model: CostModel) {
        
    }
    
    //缓存数据抽取方法
    class func saveData(array: [HomeYearModel]) {
        NSKeyedArchiver.archiveRootObject(array, toFile: kHomePath)
    }

}
