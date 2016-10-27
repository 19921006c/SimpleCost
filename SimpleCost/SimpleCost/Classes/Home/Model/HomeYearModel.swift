//
//  HomeYearModel.swift
//  SimpleCost
//
//  Created by joe on 2016/10/26.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit
private let kTime = "time"
private let kIndex = "index"
class HomeYearModel: NSObject, NSCoding {
    //那一年
    var time: Int?
    //数据队列中的次序
    var index: Int?
    //
    var costSum: Double = 0
    
    var month = [HomeMonthModel]()
    func encode(with aCoder: NSCoder) {
        aCoder.encode(time, forKey: kTime)
        aCoder.encode(index, forKey: kIndex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        time = aDecoder.decodeObject(forKey: kTime) as? Int
        index = aDecoder.decodeObject(forKey: kIndex) as? Int
    }
    
    override init() {
        super.init()
    }
}
