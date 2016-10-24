//
//  HomeModel.swift
//  SimpleCost
//
//  Created by joe on 2016/10/21.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

//获取缓存目录
let kPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
//plist 文件路径
let kHomePath = kPath + "HomeModelArray.data"

class HomeModel: NSObject {
    
    class func modelArray() -> [HomeModel]{
        var array = NSKeyedUnarchiver.unarchiveObject(withFile: kHomePath)
        
        if array == nil {
            array = [HomeModel]()
        }
        return array as! [HomeModel]
    }
}
