//
//  MainNavigationController.swift
//  SimpleCost
//
//  Created by joe on 2016/10/12.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit
import Foundation
class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override class func initialize() {
        //设置导航条透明
        let naviagationBar = UINavigationBar.appearance()
        naviagationBar.isTranslucent = true
        let color = UIColor.clear
        let rect = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        //size
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        naviagationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        
        let navBar = UINavigationBar.appearance()
        
        //去掉导航栏边界黑线
        navBar.shadowImage = UIImage()
        //设置title 颜色
        let dictionary = [NSForegroundColorAttributeName : UIColor.white, NSFontAttributeName : UIFont.systemFont(ofSize: 20)]
        navBar.titleTextAttributes = dictionary
    }
}
