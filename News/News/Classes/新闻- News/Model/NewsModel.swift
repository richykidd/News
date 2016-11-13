//
//  NewsModel.swift
//  网易新闻
//
//  Created by Liu Chuan on 2016/11/9.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class NewsModel: NSObject {
    
    // MARK: 定义属性
    var title: String = ""      // 内容标题
    var replyCount: Int = 0     // 回复数/跟帖数
    var imgsrc: String = ""     // 图片
    var source: String = ""     // 来源
    var tname: String = ""      // 分类
    
    
    
    // MARK: 定义字典转模型的构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
