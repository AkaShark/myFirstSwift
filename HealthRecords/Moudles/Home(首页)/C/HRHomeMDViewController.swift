//
//  HRHomeMDViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/30.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit
import EFMarkdown
class HRHomeMDViewController: HRBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        changeNavTitle(navTitleName: "使用说明")
        self.setIsShowLiftBakc(ShowLiftBack: true)
        self.showTheHelpWorld()
        // Do any additional setup after loading the view.
    }
    func showTheHelpWorld() -> ()
    {
        let markView = EFMarkdownView()
        markView.frame = CGRect(x: 0, y: 0, width: WIDTH, height: HEIGHT-64)
        markView.onRendered = {
            [weak self] (height) in
            if let _ = self{
                print("onRendered height: \(height ?? 0)")
            }
        }
        self.view.addSubview(markView)
        markView.load(markdown: testMarkdownFileContent(),options: [.default]){
            [weak self] (_,_) in
//            防止循环引用 类型oc里面的__block
            if let _ = self
            {
//                可以设置字体的大小
                markView.setFontSize(percent: 128)
            }
        }
    }
    public func testMarkdownFileContent() -> String
    {
        if let tempLateURL = Bundle.main.url(forResource: "AFN", withExtension: "md"){
            do {
                return try String(contentsOf: tempLateURL, encoding: String.Encoding.utf8)
            }catch
            {
                return ""
            }
        }
        return ""
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
