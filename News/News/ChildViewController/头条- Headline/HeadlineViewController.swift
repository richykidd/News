//
//  HeadlineViewController.swift
//  News
//
//  Created by Liu Chuan on 16/8/4.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class HeadlineViewController: UIViewController {
  
    
    var index: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = UIColor.purple
        // 设置随机色
        //view.backgroundColor = UIColor(colorLiteralRed: Float(arc4random_uniform(255)) / Float(255.0), green: Float(arc4random_uniform(255)) / Float(255.0), blue: Float(arc4random_uniform(255)) / Float(255.0), alpha: 1)
        
        
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
