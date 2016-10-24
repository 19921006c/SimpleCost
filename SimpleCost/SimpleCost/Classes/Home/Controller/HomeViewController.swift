//
//  HomeViewController.swift
//  SimpleCost
//
//  Created by joe on 2016/10/19.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, AddViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    var modelArray: [HomeModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        modelArray = HomeModel.modelArray()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(rightDown))
        
        title = "首页"
    }
    
    func rightDown() {
        let vc = AddViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    //添加数据页点击确定后的回调
    func finishAddData(costModel: CostModel) {
        let timestamp = NSDate().timeIntervalSince1970
        let orderNumber = Int(timestamp / 60 / 60 / 24)
        print("day = \(orderNumber)")
        print(timeStampToString(timeStamp: "\(timestamp)"))
        
        var model = modelArray?.last
        if model == nil {//没有数据
            model = createNewDayData(orderNumber: orderNumber, timestamp: timestamp)
            modelArray?.append(model!)
        }else{//有数据
            if model?.orderNumber == orderNumber {//最后数据就是今天
            }else{//最后数据不是今天
                model = createNewDayData(orderNumber: orderNumber, timestamp: timestamp)
            }
        }
        model?.costModelArray.insert(costModel, at: 0)
        
        saveData()
    }
    //将数据缓存起来
    private func saveData(){
        NSKeyedArchiver.archiveRootObject(modelArray, toFile: kHomePath)
    }
    //创建一条新的数据
    private func createNewDayData(orderNumber: Int, timestamp: Double) -> HomeModel{
        let model = HomeModel()
        model.timestamp = timestamp
        model.orderNumber = orderNumber
        return model
    }
    private func timeStampToString(timeStamp: String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy.MM.dd"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return dfmatter.string(from: date as Date)
    }
    
//    private lazy var modelArray: [HomeModel] = {
//        let array = HomeModel.modelArray()
//        return array
//    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HomeCell.cellWithTableView(tableView: tableView)
        let model = modelArray?[indexPath.row]
        cell.model = model
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
