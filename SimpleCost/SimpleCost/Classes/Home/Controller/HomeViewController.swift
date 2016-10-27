//
//  HomeViewController.swift
//  SimpleCost
//
//  Created by joe on 2016/10/19.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, AddViewControllerDelegate {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var sumLabel: UILabel!
    var modelArray: [AnyObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        modelArray = HomeDayModel.modelArryLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(rightDown))
        
        title = "首页"
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 60)
        bottomView.addSubview(effectView)
        effectView.alpha = 0.5
        
        monthLabel.text = "10月"
        monthLabel.layer.cornerRadius = 30
        monthLabel.clipsToBounds = true
    }
    
    func rightDown() {
        let vc = AddViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    //添加数据页点击确定后的回调
    func finishAddData(costModel: CostModel) {
        if modelArray.count == 0{
            //如果第一次添加则创建数据
            modelArray = HomeDayModel.modelArryLoad()
            //计算当天消费合计
            let model = modelArray.first as! HomeDayModel
            model.costSum = model.costSum! + costModel.value!
            //当月消费合计
            sumLabel.text = "支出\n\(model.costSum)"
            //插入消费模型
            modelArray.insert(costModel, at: 1)
            //刷新
            tableView.reloadData()
        }else{
            //插入消费模型
            modelArray.insert(costModel, at: 1)
            //计算当天消费合计
            let model = modelArray.first as! HomeDayModel
            model.costSum = model.costSum! + costModel.value!
            //当月消费合计
            sumLabel.text = "支出\n\(model.costSum)"
            //刷新数据
            perform(#selector(refreshTableView), with: nil, afterDelay: 0.25)

        }
        saveData()
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
        return modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let model = modelArray[row]

        if model.isKind(of: CostModel.self){//消费模型
            let cell = HomeCell.cellWithTableView(tableView: tableView)
            cell.model = model as? CostModel
            return cell
        }else if model.isKind(of: HomeDayModel.self){//天
            let cell = HomeHeaderCell.cellWithTableView(tableView: tableView)
            cell.model = model as? HomeDayModel
            return cell
        }else{//年,yue
            let cell = HomeMonthAndYearCell.cellWithTableView(tableView: tableView)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y + scrollView.contentInset.top
        if y < 1000{
            
        }
    }
}
