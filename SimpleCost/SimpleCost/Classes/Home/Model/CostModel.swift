//
//  CostModel.swift
//  SimpleCost
//
//  Created by joe on 2016/10/24.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

private let kTitle = "title"
private let kValue = "value"
private let kType = "type"
enum CostType {
    //默认类型
    case Default
}
class CostModel: NSObject, NSCoding {
    //消费类型,没有指定时，就是默认类型
    var type = CostType.Default
    //title
    var title: String?{
        get{
            if type == CostType.Default {
                return "消费"
            }else{
                return self.title
            }
        }
    }
    //消费金额
    var value: Double?
    
    func encode(with aCoder: NSCoder) {
//        aCoder.encode(type, forKey: kType)
        aCoder.encode(value, forKey: kValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
//        aDecoder.decodeInteger(forKey: kType)
        value = aDecoder.decodeObject(forKey: kValue) as? Double
    }
    
    override init() {
        super.init()
    }
}
