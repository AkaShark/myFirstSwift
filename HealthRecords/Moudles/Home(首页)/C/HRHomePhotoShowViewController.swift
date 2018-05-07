//
//  HRHomePhotoShowViewController.swift
//  HealthRecords
//
//  Created by kys-20 on 2018/4/29.
//  Copyright © 2018年 kys-20. All rights reserved.
//

import UIKit

class HRHomePhotoShowViewController: HRBaseViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.changeNavTitle(navTitleName: "查看原图")
        setIsShowLiftBakc(ShowLiftBack: false)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showTheImage(showImage:UIImage) -> ()
    {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: WIDTH ,height: self.view.frame.size.height/4))
        image.image = showImage
        self.view.addSubview(image)
        
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
