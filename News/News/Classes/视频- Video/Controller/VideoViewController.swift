//
//  VideoViewController.swift
//  News
//
//  Created by Liu Chuan on 16/8/10.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class VideoViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 蓝色
        let colorLan = UIColor(hue:0.56, saturation:0.76, brightness:1.00, alpha:1.00)
        // 设置导航栏背景色
        navigationController?.navigationBar.barTintColor = colorLan
        //修改导航栏文字颜色
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
