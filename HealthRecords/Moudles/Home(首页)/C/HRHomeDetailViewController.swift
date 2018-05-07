//
//  HRHomeDetailViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/23.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

protocol HRHomeDetailViewDelegate {
    func btnClick(textField:NSString,cell:HRHomeBtnUploadTableViewCell)
    func fiveBtnClick(textField: NSString,cell:HRHomeBtnUploadTableViewCell)
}

class HRHomeDetailViewController: HRBaseViewController {

    
    var placeHoldTag: Int?
    
    var cell = HRHomeBtnUploadTableViewCell()
    
    var delegateBtnClick:HRHomeDetailViewDelegate?
    
    let detailView = HRHomeDetailView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT))
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setIsShowLiftBakc(ShowLiftBack: true)
        if placeHoldTag == 100
        {
            detailView.txtField?.placeholder = "请输入医院名称"
            self.changeNavTitle(navTitleName: "请输入医院名称")
            detailView.btn.addTarget(self, action: #selector(finishBtnClick), for: .touchUpInside)
        }
        else if placeHoldTag == 101 {
            detailView.txtField?.placeholder = "请输入科室名称"
            self.changeNavTitle(navTitleName: "请输入科室名称")
            detailView.btn.addTarget(self, action: #selector(fiveFinishBtnClick), for: .touchUpInside)
        }
        
        self.view.addSubview(detailView)
        

        // Do any additional setup after loading the view.
    }
    
    @objc func finishBtnClick()
    {
        self.delegateBtnClick?.btnClick(textField: detailView.txtField.text! as NSString, cell: self.cell)
        
        self.navigationController?.popViewController(animated: true)
        
    }
    @objc func fiveFinishBtnClick(){
        self.delegateBtnClick?.fiveBtnClick(textField: detailView.txtField.text! as NSString, cell: self.cell)
        self.navigationController?.popViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
