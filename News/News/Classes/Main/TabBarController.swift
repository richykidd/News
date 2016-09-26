//
//  ViewController.swift
//  News
//
//  Created by Liu Chuan on 16/8/12.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         //设置全局颜色
       // UITabBar.appearance().tintColor = UIColor(hue:0.56, saturation:0.76, brightness:1.00, alpha:1.00)
        // 蓝色
//        let colorLan = UIColor(hue:0.56, saturation:0.76, brightness:1.00, alpha:1.00)
//        // 设置导航栏背景色
//        navigationController?.navigationBar.barTintColor = colorLan
//        
        
        
        // 修改状态栏的颜色白色.默认是黑色
//        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

