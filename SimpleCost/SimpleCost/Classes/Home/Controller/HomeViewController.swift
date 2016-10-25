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
    var modelArray: [HomeModel]!
    
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
        let model = modelArray?.last
        model?.costModelArray.insert(costModel, at: 0)
        saveData()
//        tableView.reloadData()
        perform(#selector(refreshTableView), with: nil, afterDelay: 0.25)
    }
    func refreshTableView() {
        var indexPath = IndexPath(row: 1, section: 0)
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        indexPath = IndexPath(row: 0, section: 0)
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
    }
    //将数据缓存起来
    private func saveData(){
        NSKeyedArchiver.archiveRootObject(modelArray, toFile: kHomePath)
    }
    private func timeStampToString(timeStamp: String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy.MM.dd"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return dfmatter.string(from: date as Date)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = modelArray[section]
        
        return model.costModelArray.count + 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let headerCell = HomeHeaderCell.cellWithTableView(tableView: tableView)
        let cell = HomeCell.cellWithTableView(tableView: tableView)
        let model = modelArray[indexPath.section]
        let row = indexPath.row
        if row == 0 {
            headerCell.model = model
            return headerCell
        }else{
            cell.model = model.costModelArray[row - 1]
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
