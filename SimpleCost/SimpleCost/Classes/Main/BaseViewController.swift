//
//  BaseViewController.swift
//  SimpleCost
//
//  Created by J on 2016/10/12.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit

let kScreenBound = UIScreen.main.bounds
let kScreenWidth = kScreenBound.width
let kScreenHeight = kScreenBound.height
class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackGroundColor()
    }
    
    func setBackGroundColor() {
        let image = UIImage(named: "Constellation_bg")
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(kScreenBound.size, false, scale)
        image?.draw(in: CGRect(x: 0, y: 0, width: kScreenBound.width, height: kScreenBound.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: newImage!)
    }
}
