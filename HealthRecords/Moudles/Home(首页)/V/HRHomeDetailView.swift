//
//  HRHomeDetailView.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import SnapKit

class HRHomeDetailView: UIView,UITextFieldDelegate {

    var txtField : UITextField!
    var lines : UIView!
    var btn : UIButton!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUI() -> (){
        
        txtField = UITextField()
        txtField.delegate = self
        txtField.becomeFirstResponder()
        txtField.borderStyle = .none
        txtField.clearButtonMode = .whileEditing
        txtField.isEnabled = true
        self.addSubview(txtField)
        txtField.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(20)
            make.width.equalTo(WIDTH-95)
            make.height.equalTo(30)
        }
        lines = UIView()
        lines.backgroundColor = MainColor
        self.addSubview(lines)
        lines.snp.makeConstraints { (make) in
            make.left.equalTo(txtField)
            make.top.equalTo(txtField.snp.bottom).offset(1)
            make.width.equalTo(txtField).offset(60)
            make.height.equalTo(1)
        }
        btn = UIButton()
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
//        btn.addTarget(self, action: #selector(HRHomeDetailViewController.finishBtnClick), for: .touchUpInside)
//        
        self.addSubview(btn)
        btn.snp.makeConstraints { (make) in
            make.left.equalTo(txtField.snp.right).offset(2)
            make.top.equalTo(txtField)
            make.width.equalTo(50)
            make.height.equalTo(30)
        }
        
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let txt = txtField.text
        let len = (txt?.characters.count)! + string.count - range.length
        return len<=8
    }
  
}
