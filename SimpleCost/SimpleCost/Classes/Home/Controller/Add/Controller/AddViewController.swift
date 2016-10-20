//
//  AddViewController.swift
//  SimpleCost
//
//  Created by joe on 2016/10/19.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: NSObjectProtocol {
    func finishAddData()
}
private let identifier = "AddViewControllerCollectionCell"
class AddViewController: BaseViewController {

    weak var delegate: AddViewControllerDelegate?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var firstNumber: Float = 0.00
    var secondNumber: Float = 0.00
    var computing: Bool = false
    var decimaling: Bool = false
    var resultNum: Float = 0
    enum ComputeType {
        case addition//加
        case subtraction//减法
    }
    var compute: ComputeType = ComputeType.addition
    
    var array = NSArray(contentsOfFile: Bundle.main.path(forResource: "array.plist", ofType: nil)!)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(UINib(nibName: identifier, bundle: nil), forCellWithReuseIdentifier: identifier)
        collectionView.isScrollEnabled = false
        let layout = UICollectionViewFlowLayout()
        let width = (kScreenWidth - 1.5) / 4
        let height: CGFloat =  (176 - 1.5) / 4
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumLineSpacing = 0.5
        layout.minimumInteritemSpacing = 0.5
        collectionView.collectionViewLayout = layout
        
        
    }
    @IBAction func closeBtnAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AddViewControllerCollectionCell
        cell.content = array?.object(at: indexPath.item) as! String?
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = indexPath.item
        if indexPath.item == 3 || indexPath.item == 7 || indexPath.item == 11 || indexPath.item == 15{
            decimaling = false
            if item == 7 {//+
                compute = ComputeType.addition
                resultNum = 0
                recordLabel.text = "\(firstNumber) + \(secondNumber)"
                computing = true
                return
            }
            if item == 11 {//-
                compute = ComputeType.subtraction
                resultNum = 0
                recordLabel.text = "\(firstNumber) - \(secondNumber)"
                computing = true
            }
            if item == 15 || item == 3{//=
                if compute == ComputeType.addition {
                    resultNum = firstNumber + secondNumber
                }else{
                    resultNum = firstNumber - secondNumber
                }
                firstNumber = resultNum
                secondNumber = 0
                recordLabel.text = ""
                label.text = "\(resultNum)"
                if item == 3 {
                    self.delegate?.finishAddData()
                    dismiss(animated: true, completion: nil)
                    return
                }
                return
            }
            
        }else if indexPath.item == 12 {
            decimaling = false
        }else if item == 14{//.
            decimaling = true
        
        }else {
            let str = (array?.object(at: indexPath.item))! as! NSString
            let number = str.floatValue
            if !computing {
                if firstNumber * 10 > 1000000{
                    return
                }
                if decimaling {
                    let int: Int = Int(firstNumber)
                    firstNumber = Float(int) + number * 0.1
                }else{
                    firstNumber = firstNumber * 10 + number
                }
                
                recordLabel.text = "\(firstNumber)"
                label.text = "\(firstNumber)"
            }else {
                if secondNumber * 10 > 1000000 {
                    return
                }
                
                if decimaling {
                    let int: Int = Int(secondNumber)
                    secondNumber = Float(int) + number * 0.1
                }else{
                    secondNumber = secondNumber * 10 + number
                }
                if compute == ComputeType.addition {
                    recordLabel.text = "\(firstNumber) + \(secondNumber)"
                }else{
                    recordLabel.text = "\(firstNumber) - \(secondNumber)"
                }
                label.text = "\(secondNumber)"
            }
            
        }
    }
}
