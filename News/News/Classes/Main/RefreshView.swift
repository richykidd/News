//
//  RefreshView.swift
//  News
//
//  Created by Liu Chuan on 2016/11/18.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

// MARK: - 自定义刷新视图
class RefreshView: UIView {

    
    private unowned var scrollView : UIScrollView
    
    init(frame: CGRect, scrollView: UIScrollView) {
        
        self.scrollView = scrollView
        
        super.init(frame: frame)
        
        backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
