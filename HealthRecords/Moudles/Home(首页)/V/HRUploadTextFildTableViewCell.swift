//
//  HRUploadTextFildTableViewCell.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/25.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

protocol passThePatientID
{
    func passThePatientID(string: String)
}

class HRUploadTextFildTableViewCell: UITableViewCell,UITextViewDelegate
{

    let placeholderLabel = UILabel()
    var textView = UITextView()
    var delagate: passThePatientID?
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 设置UI
    func setUpUI() -> ()
    {
       textView = UITextView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 170/1004*HEIGHT))
//        textView.backgroundColor = .red
        textView.isSelectable = true
        textView.isEditable = true
        textView.returnKeyType = UIReturnKeyType.done
        textView.delegate = self
        textView.layer.borderWidth = 1
        textView.layer.borderColor = MainColor.cgColor
        self.addSubview(textView)
        
        placeholderLabel.frame = CGRect.init(x: 5, y: 5, width: 100, height: 20)
        placeholderLabel.font = secondFont
        placeholderLabel.text = "请输入病情信息"
        self.addSubview(placeholderLabel)
        placeholderLabel.textColor = UIColor(red: 72/256, green:  82/256, blue: 93/256, alpha: 1)
        
    }
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.placeholderLabel.isHidden = true
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty
        {
            self.placeholderLabel.isHidden = false
        }
        else
        {
            self.delagate?.passThePatientID(string: textView.text)
            self.placeholderLabel.isHidden = true
        }
    }
    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
