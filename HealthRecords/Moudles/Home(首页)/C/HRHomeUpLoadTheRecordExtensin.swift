
//
//  HRHomeUpLoadTheRecordExtensin.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/27.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import Foundation
import SwiftyJSON
import PKHUD
extension HRHomeUpLoadTheRecordViewController
{
    /// 获取Api数据
    func getTheOrcData(image: UIImage) -> ()
    {
        self.photoWeight = image.size.width
        self.photoHeaight = image.size.height
        //        将image转成data
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        
        //        let file = Bundle.main.path(forResource:"images", ofType: "jpeg")!
        //        let fileUrl = URL(fileURLWithPath: file)
        //        let fileData = try!Data(contentsOf:fileUrl)
        //        //        将data装成照片
        //        let photo = UIImage(data: fileData)
        //        photoWeight = photo?.size.width
        //        photoHeaight = photo?.size.height
        
        //将图片转为base64编码
        let base64 = imageData?.base64EncodedString(options: .endLineWithLineFeed)
        
        //继续将base64字符串转为urlencode
        let imageString = base64?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        request(imageString: imageString!)
    }
    
    func request(imageString: String) -> ()
    {
        //接口地址
        let httpUrl = "https://aip.baidubce.com/rest/2.0/ocr/v1/receipt?access_token=24.a716688f18f164ea22a54cf4c5d80b58.2592000.1525854532.282335-11066078"
        //参数拼接
        let httpArg = "fromdevice=iPhone&clientip=10.10.10.0&detecttype=LocateRecognize" +
            "&languagetype=CHN_ENG&imagetype=1&image=" + imageString
        //创建请求对象
        var request = URLRequest(url: URL(string: httpUrl)!)
        request.timeoutInterval = 6
        request.httpMethod = "POST"
        //添加头信息apikey
        request.addValue("zOIaYmMotvQBWyNyEiiFUdn9", forHTTPHeaderField: "apikey")
        //设置请求内容
        request.httpBody = httpArg.data(using: .utf8)
        //使用URLSession发起请求
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request,
                                        completionHandler: {(data, response, error) -> Void in
                                            if error != nil{
                                                HUD.flash(.label("测试图片失败请重新上传"), delay: 0.5) { _ in
                                                    print("License Obtained.")
                                                }
                                                print(error.debugDescription)
                                            }else if let d = data{
                                                let str = String(data: d, encoding: .utf8)!
                                                print("----- 原始数据 -----\n\(str)")
                                                
                                                //解析数据并显示结果
                                                self.showResult(data: d)
                                            }
        }) as URLSessionTask
        
        //使用resume方法启动任务
        dataTask.resume()
    }
    
    
    //解析数据并显示结果
    func showResult(data:Data) {
        let json = try! JSON(data: data)
        
//        if json["words_result"].isEmpty
//        {
//           HUD.flash(.label("输入的图像信息有错误"), delay: 0.5)
//            return
//        }
        
        //循环每个区域识别出来的内容
        for (_,subJson):(String, JSON) in json["words_result"]
        {
            //            result.append("-- 区域（")
            //            result.append("左|\(subJson["location"]["left"].intValue) ")
            //            result.append("上|\(subJson["location"]["top"].intValue) ")
            //            result.append("宽度|\(subJson["location"]["width"].intValue) ")
            //            result.append("高度|\(subJson["location"]["height"].intValue)）--\n")
            //            result.append("\(subJson["words"].stringValue)\n\n") //识别的内容
            
            self.leftLocal.append(subJson["location"]["left"].intValue)
            self.topLocal.append(subJson["location"]["top"].intValue)
            self.widthLocal.append(subJson["location"]["width"].intValue)
            self.heightLocal.append(subJson["location"]["height"].intValue)
            self.textArray.append(subJson["words"].stringValue)
        }
        //        转化
        for i in 0..<self.heightLocal.count
        {
            self.xConversion.append(CGFloat(self.leftLocal[i] as! Int)/self.photoWeight!*WIDTH)
            self.yConversion.append(CGFloat(self.topLocal[i] as! Int)/self.photoHeaight!*HEIGHT)
            self.widthConversion.append(CGFloat(self.widthLocal[i] as! Int)/self.photoWeight!*WIDTH)
            self.heightConversion.append(CGFloat(self.heightLocal[i] as! Int)/self.photoHeaight!*HEIGHT)
        }
        //        print("-->",self.yConversion,self.textArray)
        
        // error
//        if self.textArray.isEmpty
//        {
//            HUD.flash(.label("输入的图像信息有错误"), delay: 0.5)
//        }
//        else
//        {
        
            //       处理信息返回所需数据
            let dic1 = ["Word":self.textArray[0],"Width":self.widthConversion[0],"Height":heightConversion[0],"X":xConversion[0],"Y":yConversion[0]]
            
            /// 一行数据(默认第一行)
            var sameLine = [dic1]
            
            var j = 0
            for i in 1..<self.yConversion.count
            {
                if(Int(self.yConversion[i] as! CGFloat) - Int(self.yConversion[i-1] as! CGFloat) < 10)
                {
                    let dic2 = ["Word":self.textArray[i],"Width":self.widthConversion[i],"Height":heightConversion[i],"X":xConversion[i],"Y":yConversion[i]]
                    sameLine.append(dic2)
                    if i == self.yConversion.count
                    {
                        j += 1
                        self.dicData.updateValue(sameLine, forKey: j)
                    }
                }
                else
                {
                    if sameLine.count >= 1
                    {
                        self.dicData.updateValue(sameLine, forKey: j)
                        j += 1
                        sameLine.removeAll()
                    }
                    
                    let dic = ["Word":self.textArray[i],"Width":self.widthConversion[i],"Height":heightConversion[i],"X":xConversion[i],"Y":yConversion[i]]
                    sameLine.append(dic)
                }
                
            }
            
            DispatchQueue.main.async(execute: {
                self.justTheAllDataDrawLineView()
            })
            
            ////        返回的数据
            //        print(self.dicData)
//        }
    }
    
}


