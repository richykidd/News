//
//  AppleViewCell.swift
//  News
//
//  Created by Liu Chuan on 2016/11/16.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class AppleViewCell: UITableViewCell {
    
    // MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!  // 图片
    @IBOutlet weak var titleLabel: UILabel!         // 内容标题
    @IBOutlet weak var sourceLabel: UILabel!        // 来源
    @IBOutlet weak var replyCountLabel: UILabel!    // 回复数/跟帖


    
    // MARK:- 定义模型属性
    var newModel: NewsModel? {
        // 监听模型改变
        didSet {
            
            // 设置基本信息
            titleLabel.text = newModel?.title
            sourceLabel.text = newModel?.source
            replyCountLabel.text = "\(newModel?.replyCount ?? 0)跟帖"
            
            // 设置图片
            let iconURL = URL(string: newModel?.imgsrc ?? "")
            iconImageView.kf.setImage(with: iconURL)
            
            
        }
}

}
