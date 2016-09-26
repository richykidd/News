//
//  ContentView.swift
//  News
//
//  Created by Liu Chuan on 2016/9/26.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

// 内容视图
class ContentView: UIView {

    // MARK:- 定义属性
     var childVCs: [UIViewController]
     var parentViewController: UIViewController
    
    
    
    //MARK:- 懒加载属性
    // 集合视图
     lazy var collectionView : UICollectionView = {[weak self] in
        
        // 1.创建layout
        // 创建 UICollectionViewFlowLayout 布局对象
        // UICollectionView 的layout 属性: 支持 Flow\ Custom 2中布局方式. 横排\纵排 -> 网格
        
        let layout = UICollectionViewFlowLayout()
        
         // 设置 collectionView 单元格的大小
        layout.itemSize = (self?.bounds.size)!
        
        // 设置 collectionView 单元格之间的最小 行 间距
        layout.minimumLineSpacing = 0
        
        // 设置 collectionView 单元格之间的最小 列 间距
        layout.minimumInteritemSpacing = 0
        
        // 设置 UICollectionView 布局方向为: 水平滚动
        layout.scrollDirection = .horizontal
        
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        // 是否显示水平方向指示器
        collectionView.showsVerticalScrollIndicator = false
        
        // 是否分页显示
        collectionView.isPagingEnabled = true
        
        // 设置边缘是否弹动效果
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        
        
        collectionView.dataSource = self
        
        // 注册 cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        
        return collectionView
        
        
        
        
    }()
    
    
    
    // MARK:- 自定义构造函数
    
    // 参数: frame\ 对应的控制器 \ 父控制器
    init(frame: CGRect, childVCs: [UIViewController], parentViewController: UIViewController) {
        self.childVCs = childVCs
        self.parentViewController = parentViewController
     
        super.init(frame: frame)
        
        
        // 设置 UI
        setupUI()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


//MARK:- 设置 UI 界面
extension ContentView {
    
     func setupUI() {
        
        // 将所有的子控制器添加到父控制器中
        for childV in childVCs {
            parentViewController.addChildViewController(childV)
        }

        // 添加 UICollectionView, 方便 cell 中存放控制器的 View
        addSubview(collectionView)
        
        collectionView.frame = bounds
    }
}


// MARK:- 遵守 UICollectionViewDataSource协议

extension ContentView: UICollectionViewDataSource {
    
    // 设置 集合视图单元格的数量
    // 每一组有多少条数据
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVCs.count
        
    }
    
    
    // 初始化\返回集合视图的单元格
    // 每一行 cell 的显示具体内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 创建单元格重用标识符
        let identify = "cell"
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath)
        
        
        // 给 cell设置内容
        let childV = childVCs[indexPath.item]
        childV.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childV.view)

        
        return cell

    }
    
}












