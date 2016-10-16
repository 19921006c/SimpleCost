//
//  MainNavigationController.swift
//  SimpleCost
//
//  Created by J on 2016/10/12.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    }


}
