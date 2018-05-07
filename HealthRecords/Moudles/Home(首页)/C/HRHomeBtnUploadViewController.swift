//
//  HRHomeBtnUploadViewController.swift
//  HealthRecords
//
//  Created by kys-3 on 2018/4/22.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import PKHUD


class HRHomeBtnUploadViewController: HRBaseViewController,UITableViewDelegate,UITableViewDataSource,HRHomeBtnFirstCellClickViewControllerDelegate,HRHomeDetailViewDelegate,HRHomeBtnThirdCellClickViewControllerDelegate,passThePatientID
{
    
    var titleArr1: Array<Any>!
    var titleArr2: Array<Any>!
    var detailArr1: Array<Any> =  ["选择报告类型","选择时间"]
    var detailArr2: Array<Any> =  ["请选择就诊人","选择就诊医院","请选择科室"]
    var detailTextFiledText: String!
    var cellTag: Int!
    
    
    var isNormalInput: Bool = true
    
    var type: String?
    var patient: String?
    var hospital: String?
    var department: String?
    var upLoadTime: String?
    var detaileText: String?
    var objID: String?
    
    var  photoBtn = HRLoginBaseButton.init(frame: CGRect.init(x: 0, y: 0, width: LoginBtnW, height: LoginBtnH), btnTitle: "添加单据", btnColor: .white, titleColor: .white, isSelected: true)
    
    override func viewWillAppear(_ animated: Bool) {
        if isNormalInput
        {
            self.photoBtn.isHidden = false
        }
        else
        {
            let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named:"分享-3"), for: .normal)
            btn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            btn.addTarget(self, action: #selector(shareTheRecord), for: .touchUpInside)
            
            let item = UIBarButtonItem(customView: btn)
            self.navigationItem.rightBarButtonItem = item
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: self.view.frame.size.height))
            self.view.addSubview(view)
            self.photoBtn.isHidden = true
        }
    }
    
    @objc func shareTheRecord ()
    {
        
        UMSocialSwiftInterface.setPreDefinePlatforms([
            (UMSocialPlatformType.wechatSession.rawValue),
            (UMSocialPlatformType.wechatTimeLine.rawValue),
            (UMSocialPlatformType.QQ.rawValue),
            (UMSocialPlatformType.qzone.rawValue)
            ])
        
        UMSocialUIManager.removeAllCustomPlatformWithoutFilted()
        UMSocialShareUIConfig.shareInstance().sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType.middle
        UMSocialShareUIConfig.shareInstance().sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType.none
        
        UMSocialSwiftInterface.showShareMenuViewInWindowWithPlatformSelectionBlock { (platformType, userInfo) in
            self.runShareWithType(type: platformType)
        }
    }
    
    func runShareWithType(type:UMSocialPlatformType) -> Void {
        print("runShareWithType-----\(type)")
        
        let messageObject = UMSocialMessageObject.init()
        //       分享的文字之类的信息
        messageObject.text = "终于搞定了，😄\n欢迎使用【友盟+】社会化组件U-Share，SDK包最小，集成成本最低，助力您的产品开发、运营与推广！"
        UMSocialSwiftInterface.share(plattype: type, messageObject: messageObject, viewController: self) { (data, error) in
            if (error != nil) {
                
            }else{
                
            }
        }
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        titleArr1 = ["报告类型","就诊日期"]
        titleArr2 = ["就诊人","就诊医院","就诊科室"]
       
        
        self.setIsShowLiftBakc(ShowLiftBack: true)
        if isNormalInput
        {
            self.changeNavTitle(navTitleName: "上传就医记录")
        }
        else
        {
            self.changeNavTitle(navTitleName: "查看就医记录")
        }
        
        let tableView = lazyTableView
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        self.view.addSubview(tableView)
        
        
        let footView = UIView.init(frame: CGRect.init(x: 0, y: 0, width:LoginBtnW, height: LoginBtnH*2))
       
        photoBtn.addTarget(self, action:#selector(clickThePhoto), for: .touchUpInside)
        footView.addSubview(photoBtn)
//
        photoBtn.snp.makeConstraints { (make) in
            make.left.equalTo(footView).offset(WIDTH/2-LoginBtnW/2)
            make.centerY.equalTo(footView.centerY)
            make.width.equalTo(LoginBtnW)
            make.height.equalTo(LoginBtnH)
        }
        
        tableView.tableFooterView = footView
        
        
        // Do any additional setup after loading the view.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2
        }else if section == 1{
            return 3
        }else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = HRHomeBtnUploadTableViewCell(style: .value1, reuseIdentifier: "reuseIdentifier")
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        if indexPath.section == 0{
            cell.txtLabel?.text = (titleArr1 as! Array<String>)[indexPath.row]
            
            cell.detailLabel?.text = (detailArr1 as! Array<String>)[indexPath.row]
            return cell
        }else if indexPath.section == 1{
            cell.textLabel?.text = (titleArr2 as! Array<String>)[indexPath.row]
            cell.detailLabel?.text = (detailArr2 as! Array<String>)[indexPath.row]
            return cell
        }
        else{
            let textCell = HRUploadTextFildTableViewCell(style: .default, reuseIdentifier: "textCell")
            textCell.setUpUI()
            textCell.textView.text = self.detailTextFiledText
            textCell.delagate = self
            if isNormalInput
            {
//                textCell.placeholderLabel.isEnabled = false
            }
            else
            {
                textCell.placeholderLabel.text = ""
            }
           
            return textCell
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48/1004*HEIGHT
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        if section == 2
        {
            return 20
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 85/1004*HEIGHT
        }
        else if indexPath.section == 1
        {
            return 85/1004*HEIGHT
        }
        else
        {
            return 170/1004*HEIGHT
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let passCell = tableView.cellForRow(at: indexPath)
        
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cellClick =  HRHomeBtnFirstCellClickViewController()
                cellClick.cell = passCell as? HRHomeBtnUploadTableViewCell
                cellClick.delegate = self
                self.navigationController?.pushViewController(cellClick, animated: true)
                
            }
            
            if indexPath.row == 1 {
                let cell = passCell as! HRHomeBtnUploadTableViewCell
                let picker = KSDatePicker(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 300))
                picker.centerY = self.view.centerY
                picker.centerX = self.view.centerX
                
                picker.appearance.radius = 5
                self.view.addSubview(picker)
                picker.appearance.resultCallBack = {(datePicker,currentDate,buttonType) ->Void in
                    if buttonType == KSDatePickerButtonType.commit
                    {
                        let date = self.stringWithFormat(date: currentDate!)
                        cell.detailLabel?.text = date
                        self.upLoadTime = date
                    }
                }
            }
        }else if indexPath.section == 1{
            if indexPath.row == 0{
                let thirdCellClick = HRHomeBtnThirdCellClickViewController()
                
                thirdCellClick.cell = (passCell as? HRHomeBtnUploadTableViewCell)!
                thirdCellClick.delegateTHIRD = self
                self.navigationController?.pushViewController(thirdCellClick, animated: false)
            }else if indexPath.row == 1{
                let forthCellClick = HRHomeDetailViewController()
                let detailView = HRHomeDetailView()
                detailView.txtField?.tag = 100
                forthCellClick.placeHoldTag =  detailView.txtField?.tag
                forthCellClick.cell = (passCell as? HRHomeBtnUploadTableViewCell)!
                forthCellClick.delegateBtnClick = self
                self.navigationController?.pushViewController(forthCellClick, animated: false)
                
            }else if indexPath.row == 2{
                let forthCellClick = HRHomeDetailViewController()
                forthCellClick.cell = (passCell as?HRHomeBtnUploadTableViewCell)!
                
                forthCellClick.delegateBtnClick = self
                
                let detailView = HRHomeDetailView()
                detailView.txtField?.tag = 101
                forthCellClick.placeHoldTag = detailView.txtField?.tag
                
                self.navigationController?.pushViewController(forthCellClick, animated: false)
            }
        }
    }
    
    
    func cellClick(cellTxt: String, cell: HRHomeBtnUploadTableViewCell) {
        
        cell.detailLabel?.text = cellTxt
        type = cellTxt
//        print(cell.detailLabel?.text ?? String())
        
        //        self.lazyTableView.reloadData()
    }
    
    func avatorCellClick(objID: String, labelTxt: NSString, cell: HRHomeBtnUploadTableViewCell) {
        cell.detailLabel?.text = labelTxt as String
        patient = labelTxt as String
        self.objID = objID
    }
    
    func btnClick(textField: NSString, cell: HRHomeBtnUploadTableViewCell) {
        
        cell.detailLabel?.text = textField as String
        hospital = textField as String
    }
    
    func fiveBtnClick(textField: NSString, cell: HRHomeBtnUploadTableViewCell) {
        cell.detailLabel?.text = textField as String
        department = textField as String
        
    }
    
    func passThePatientID(string: String) {
        self.detaileText = string
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 转换时间
    ///
    /// - Parameter date:
    /// - Returns:
    func stringWithFormat(date:Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    
    /// 点击photo时间
    @objc func clickThePhoto() -> ()
    {
        if hospital == nil || type == nil || patient == nil || department == nil || upLoadTime == nil || detaileText == nil
        {
//            print("数据没有填写完全")
            HUD.flash(.label("数据没有填写完全"), delay: 0.5) { _ in
                print("License Obtained.")
            }
        }
        else
        {
            self.upLoadTheBmobData()
        }
    
    }
    
    func upLoadTheBmobData() -> ()
    {
        let medicinalRecord: BmobObject = BmobObject(className: "medicinalRecord")
        medicinalRecord.setObject(hospital, forKey: "patientHospital")
        medicinalRecord.setObject(type, forKey: "medicinalType")
        // 这个是上传patlentID
        medicinalRecord.setObject(objID, forKey: "patientID")
        medicinalRecord.setObject(department, forKey: "hospitalOffice")
        medicinalRecord.setObject(upLoadTime, forKey: "medicinalTime")
        medicinalRecord.setObject(detaileText, forKey: "diseaseDescribe")
        
        medicinalRecord.saveInBackground { (isSuccessfule, error) in
            if error != nil{
                print(error ?? "上传数据没有错误")
            }
            else{
                print("上传数据成功")
//                HUD正在上传 跳转到oc去上传图片 带着objID真的medicinalRecord.objectId 和图片的命名
                HUD.flash(.success, delay: 0.5)
                
                let vc = HWPublishBaseController()
                vc.objectID = medicinalRecord.objectId
                vc.initPickerView()
                vc.collectionFrameY = vc.view.centerY
                vc.maxCount = 4
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    
}

