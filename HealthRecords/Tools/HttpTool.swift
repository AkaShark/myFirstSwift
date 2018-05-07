//
//  HttpTool.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/9.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import Alamofire


public typealias Success = (_ response : [String : Any])->()
public typealias Failure = (_ error : Error)->()

class HttpTool: NSObject {
    //创建单例
    static let shareInstance: HttpTool = {
        let tools = HttpTool()
        return tools
    }()
}

//MARK: - 网络请求封装
extension HttpTool
{
    
    private class func request(
        _ urlString: String,
        params: Parameters?=nil,
        method: HTTPMethod,
        _ success: @escaping Success,
        _ failure: @escaping Failure)
    {
        Alamofire.request(urlString, method: method, parameters: params).validate(statusCode:200..<300).responseJSON { response in
            
            switch response.result {
            case .success:
                if let value = response.result.value as? [String: AnyObject] {
                    success(value)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    /// get请求
    ///
    /// - Parameters:
    ///   - urlString: 请求url
    ///   - params: 参数
    ///   - success: 成功回调
    ///   - failure: 失败回调
    class func getRequest(
        _ urlString: String,
        params: Parameters? = nil,
        success: @escaping Success,
        failure: @escaping Failure)
    {
        request(urlString, params: params, method: .get, success, failure)
    }
    
    
    /// post 请求
    ///
    /// - Parameters:
    ///   - urlString: 请求url
    ///   - params: 参数
    ///   - success: 成功回调
    ///   - faileure: 失败回调
    class func postRequest(
        _ urlString: String,
        params: Parameters? = nil,
        success: @escaping Success,
        faileure: @escaping Failure)
    {
        request(urlString, params: params, method: .post, success, faileure)
    }
    
    
    
    /// 将图片转为base64和urlEncode
    ///
    /// - Parameters:
    ///   - nameString: 图片的名字
    ///   - typeString: 图片的类型
    /// - Returns: 返回编码为base64的urlencode
    
    class func transformTheImage(nameString:String,typeString:String) -> String
    {
        let file = Bundle.main.path(forResource: nameString, ofType: typeString)!
        let fileUrl = URL(fileURLWithPath:file)
        let fileData = try!Data(contentsOf:fileUrl)
        //将图片转化为base64编码
        let base64 = fileData.base64EncodedString(options: .endLineWithLineFeed)
        //继续将base64字符串转化为urlencode
        let imageString = base64.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
        return imageString!
    }
    
    
    
    /// 请求百度API
    ///
    /// - Parameter imageString: imageURL
    /// - Returns: 请求回来的数据
//    class func requestTheApi(imageString:String,accessToke:String)
//        ->Data
//    {
//        //接口地址
//        let httpUrl = "https://aip.baidubce.com/rest/2.0/ocr/v1/receipt?access_token="+accessToke
//        //参数拼接
//        let httpArg = "fromdevice=iPhone&clientip=10.10.10.0&detecttype=LocateRecognize" +
//            "&languagetype=CHN_ENG&imagetype=1&image=" + imageString
//        let requestHeader:HTTPHeaders = ["":""]
//////         request.addValue("zOIaYmMotvQBWyNyEiiFUdn9", forHTTPHeaderField: "apikey")
////        Alamofire.request(httpUrl, method:.post, parameters: httpArg, encoding: URLEncoding.default, headers: requestHeader)
//    }
//
    
    
}


