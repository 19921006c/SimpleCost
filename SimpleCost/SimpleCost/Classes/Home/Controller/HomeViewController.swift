//
//  HomeViewController.swift
//  SimpleCost
//
//  Created by joe on 2016/10/19.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

private let identifier = "HomeCell"
class HomeViewController: BaseViewController, AddViewControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(rightDown))
        
        title = "首页"
    }
    
    func rightDown() {
        let vc = AddViewController()
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
    
    func finishAddData() {
        let date = NSDate().timeIntervalSince1970
        let tmpDay = Int(date / 60 / 60 / 24)
        print("day = \(tmpDay)")
        print(timeStampToString(timeStamp: "\(date)"))
    }
    func timeStampToString(timeStamp:String)->String {
        
        let string = NSString(string: timeStamp)
        
        let timeSta:TimeInterval = string.doubleValue
        let dfmatter = DateFormatter()
        dfmatter.dateFormat="yyyy.MM.dd"
        
        let date = NSDate(timeIntervalSince1970: timeSta)
        
        return dfmatter.string(from: date as Date)
    }
    
    private lazy var modelArray: [HomeModel] = {
        let array = HomeModel.modelArray()
        return array
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        
        if  cell == nil {
            cell = Bundle.main.loadNibNamed(identifier, owner: self, options: nil)?.last as! HomeCell
            cell?.backgroundColor = UIColor.clear
        }
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
