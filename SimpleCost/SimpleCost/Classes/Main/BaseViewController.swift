//
//  BaseViewController.swift
//  SimpleCost
//
//  Created by joe on 2016/10/19.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setBackgroundImage()
    }
    
    private func setBackgroundImage() {
        let image = #imageLiteral(resourceName: "Constellation_bg")
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(kScreenBounds.size, false, scale)
        image.draw(in: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        view.backgroundColor = UIColor(patternImage: newImage!)
    }
}
