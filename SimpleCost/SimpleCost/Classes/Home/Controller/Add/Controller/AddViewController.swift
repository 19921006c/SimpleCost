//
//  AddViewController.swift
//  SimpleCost
//
//  Created by joe on 2016/10/19.
//  Copyright © 2016年 joe. All rights reserved.
//

import UIKit

protocol AddViewControllerDelegate: NSObjectProtocol {
    func finishAddData(costModel: CostModel)
}
private let identifier = "AddViewControllerCollectionCell"
class AddViewController: BaseViewController, UITextFieldDelegate{

    weak var delegate: AddViewControllerDelegate?
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var closeBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textfieldDidChange(notification:)), name: NSNotification.Name.UITextFieldTextDidChange, object: textField)
    }
    
    @objc private func textfieldDidChange(notification: NSNotification) {
        let tmpTextField = notification.object as! UITextField
        label.text = tmpTextField.text!
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func closeBtnAction(_ sender: UIButton) {
        commonDismiss()
    }
    @IBAction func enableBtnAction(_ sender: AnyObject) {
        commonDismiss()
        let nsStr1 = textField.text! as NSString
        let value = floorToPlaces(value: nsStr1.doubleValue, places: 2)
        let model = CostModel()
        model.value = value
        delegate?.finishAddData(costModel: model)
    }
    
    func floorToPlaces(value:Double, places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (floor(value * divisor)) / divisor
    }
    
    func commonDismiss() {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    
}
