//
//  HRHomeUpLoadTheRecordViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/27.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import PKHUD
/// 获取vm耦合过高了 都没了M 时间原因没有出来M 等闲下来处理了M的问题
class HRHomeUpLoadTheRecordViewController: HRBaseViewController,backTheSelectedTextArray
{
    
    /// 选中的文字数组
    var textData = Array<Any>()
    
    var container = GTagFlowContainer()
    
    /// 图片信息
    var leftLocal = Array<Any>()
    var topLocal = Array<Any>()
    var widthLocal = Array<Any>()
    var heightLocal = Array<Any>()
    var textArray = Array<Any>()
    var photoWeight: CGFloat?
    var photoHeaight: CGFloat?
    
    var xConversion = Array<Any>()
    var yConversion = Array<Any>()
    var widthConversion = Array<Any>()
    var heightConversion = Array<Any>()
    
    //    相册
    var imagePickerController: UIImagePickerController! = nil
    var actionButton: ActionButton!
    /// 全部数据字典
    var dicData = Dictionary<Int, Any>()
    
    var selectImageFromPhotoes: UIImage?
    
    var  imageView: UIImageView = UIImageView()
    var line = 0
    /// 每行数据的数组
    var lineArray = Array<Any>()
    
    override func viewWillAppear(_ animated: Bool) {
        
        let imagePickerController: UIImagePickerController = UIImagePickerController()
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.imagePickerController = imagePickerController
        //        网络获取数据
        imageView.image = UIImage(named: "Group")
        self.view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view.snp.centerX)
            make.centerY.equalTo(self.view.snp.centerY)
            make.width.equalTo(210)
            make.height.equalTo(195)
        }
        
        
    }
    
    
    func selectTheWayForPhoto ()
    {
        let alertController = UIAlertController(title: "提示", message: "请进行上传照片的位置",preferredStyle: .actionSheet)
        //        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        
        let deleteAction = UIAlertAction(title: "拍照", style: .default) { (action) in
            let vc: CustomCameraVC = CustomCameraVC()
            vc.handleImgBlock = { image in
                //        获取照片的信息
                self.getTheOrcData(image: image)
                vc.dismiss(animated: true, completion: nil)
                self.selectImageFromPhotoes = image
            }
            self.present(vc, animated: true, completion: nil)
            self.creatTheBtn()
        }
        //        let archiveAction = UIAlertAction(title: "本地相册", style: .default, handler: nil)
        let archiveAction = UIAlertAction(title: "本地相册", style: .default) { (action) in
            self.imagePickerController.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
            //            self.present(self.imagePickerController, animated: true, completion:)
            self.present(self.imagePickerController, animated: true, completion: {
                
            })
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func creatTheBtn()
    {
        self.imageView.isHidden = true
        
        let twitter = ActionButtonItem(title: "原图", image:self.selectImageFromPhotoes)
        twitter.action = { item in
            let vc = HRHomePhotoShowViewController()
            vc.showTheImage(showImage: self.selectImageFromPhotoes!)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let google = ActionButtonItem(title: "分享", image: UIImage(named: "分享 (5)"))
        //        实现分享
        google.action = { item in
            //创建分享消息对象
            
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
        self.actionButton = ActionButton(attachedToView: self.view, items: [twitter, google])
        self.actionButton.action = { button in button.toggleMenu() }
        self.actionButton.setTitle("+", forState: UIControlState())
        
        self.actionButton.backgroundColor = MainColor
    }
    //    分享信息
    func runShareWithType(type:UMSocialPlatformType) -> Void {
        print("runShareWithType-----\(type)")
        
        let messageObject = UMSocialMessageObject.init()
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
        self.changeNavTitle(navTitleName: "确定报告单")
        self.setIsShowLiftBakc(ShowLiftBack: true)
        selectTheWayForPhoto()
        
        let button1 = UIButton(frame:CGRect(x:0, y:0, width:80, height:50))
        button1.titleLabel?.textColor = .white
        button1.setTitle("下一行", for: .normal)
        button1.addTarget(self,action:#selector(nextLine(_:)),for:.touchUpInside)
        
        
        container.flowView.backTheSelectedArray = self
        container.flowView.configTagCollectionViewLayout()
        container.actionBtnItems = ["确定"]
        container.actionBlock = {(actionTitle,newText) in
            print(actionTitle!,newText!)
            //            点击确定按钮的回调
            //            print(self.textData)
            self.createTheLineView(titleArray:self.textData as! Array<Array<Any>>, line: self.line - 1 )
            self.textData.removeAll()
            if self.line == self.dicData.count
            {
                button1.setTitle("完成", for: .normal)
            }
            let barButton1 = UIBarButtonItem(customView: button1)
            self.navigationItem.rightBarButtonItems = [barButton1]
            
        }
        
        
    }
    
    @objc func nextLine (_ button: UIButton) -> ()
    {
        if button.titleLabel?.text == "下一行"
        {
            self.justTheAllDataDrawLineView()
        }
        if button.titleLabel?.text == "完成"
        {
            
            HUD.flash(.label("分析完毕图片保存到相册"), delay: 0.5) { _ in
                print("License Obtained.")
            }
            //          完成保存相册
            writeImageToAlbum(image: self.cutImageWithView(view: self.view))
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    //    截图
    func cutImageWithView(view:UIView) -> UIImage
    {
        // 参数①：截屏区域  参数②：是否透明  参数③：清晰度
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        return image;
    }
    
    //    写入系统相册
    func writeImageToAlbum(image:UIImage)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(image:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafeRawPointer)
    {
        if let e = error as NSError?
        {
            print(e)
        }
        else
        {
            UIAlertController.init(title: nil,
                                   message: "保存成功！",
                                   preferredStyle: UIAlertControllerStyle.alert).show(self, sender: nil);
        }
    }
    
    /// 创造一行视图
    ///
    /// - Parameters:
    ///   - titleArray: <#titleArray description#>
    ///   - X: <#X description#>
    ///   - Y: <#Y description#>
    ///   - Width: <#Width description#>
    ///   - Height: <#Height description#>
    func createTheLineView(titleArray:Array<Array<Any>>,line:Int) -> ()
    {
        //        let lineView = HRHomeUpLoadTheRecordView(frame: CGRect(x: 0, y: CGFloat((self.line-1)*100), width: WIDTH, height: HEIGHT), titleArray: titleArray)
        let lineView = HRHomeUpLoadTheRecordView(frame:CGRect(x: 0, y: CGFloat((self.line-1)*80), width: WIDTH, height: 80), titleArray: titleArray, line:line)
        
        self.view.addSubview(lineView)
    }
    
    func justTheAllDataDrawLineView() -> ()
    {
        if line <= self.dicData.count {
            var string = ""
            
            for j in 0..<(self.dicData[line] as! Array<Any>).count
            {
                
                string = string + (((self.dicData[line] as! Array<Any>)[j] as!Dictionary<String,Any>)["Word"]as! String)
            }
            self.showTheLineData(string: string)
            line += 1
        }
    }
    
    ///显示一行的数据
    func showTheLineData(string:String) -> ()
    {
        var array = GBigbangBox.bigBang(string)
        let addBtn = GBigbangItem.bigbangText("如果行数少于分词数请点击添加项", isSymbol: false)
        let emptyBtn0 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn1 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn2 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn3 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        let emptyBtn4 = GBigbangItem.bigbangText("添加项", isSymbol: false)
        
        array?.append(addBtn!)
        array?.append(emptyBtn0!)
        array?.append(emptyBtn1!)
        array?.append(emptyBtn2!)
        array?.append(emptyBtn3!)
        array?.append(emptyBtn4!)
        
        let layouts = GTagFlowItem.factoryFolwLayout(with: array, with: nil)
        container.configDatas(layouts)
        container.show()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- 代理方法
    func backTheSelectedTextArray(_ array: NSMutableArray!)
    {
        let array = array as! Array<Any>
        textData.append(array)
        
    }
    
}

//拓展进入相册
extension HRHomeUpLoadTheRecordViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let data: NSData = UIImagePNGRepresentation(image)! as NSData
        weak var weakSelf = self
        picker.dismiss(animated: true) {
            //
            let vc: ImageDetailVC = ImageDetailVC()
            vc.data = data
            vc.isFromSelectImgView = true
            vc.handleImgBlock = { image in
                //处理图片
                self.selectImageFromPhotoes = image
                self.creatTheBtn()
                self.getTheOrcData(image: image)
            }
            weakSelf?.present(vc, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

