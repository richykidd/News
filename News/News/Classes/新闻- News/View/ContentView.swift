//
//  ContentView.swift
//  News
//
//  Created by Liu Chuan on 2016/9/26.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

protocol ContentViewDelegate : class {
    func ContentView(contentView : ContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}


private let identify = "cell"               // 创建单元格重用标识符

// 内容视图
class ContentView: UIView {

    // MARK:- 定义属性
    var childVCs: [UIViewController]
    weak var parentViewController: UIViewController?

    
    //MARK:- 懒加载属性
    // 集合视图: UICollectionView
     lazy var collectionView : UICollectionView = {[weak self] in
        
        // 1.创建layout
        // 创建 UICollectionViewFlowLayout 布局对象
        // UICollectionView 的layout 属性: 支持 Flow\ Custom 2中布局方式. 横排\纵排 -> 网格
        
        let layout = UICollectionViewFlowLayout()
        
         // 设置单元格的大小
        layout.itemSize = (self?.bounds.size)!
        
        // 设置单元格之间的最小 行 间距
        layout.minimumLineSpacing = 0
        
        // 设置单元格之间的最小 列 间距
        layout.minimumInteritemSpacing = 0
        
        // 设置布局方向为: 水平滚动
        layout.scrollDirection = .horizontal
        
        // 创建UICollectionView
        // CGRect.Zero: 是一个高度和宽度为零、位于(0，0)的矩形常量
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        // 是否显示水平方向指示器
        collectionView.showsVerticalScrollIndicator = false
        
        // 是否分页显示
        collectionView.isPagingEnabled = true
        
        // 设置边缘是否弹动效果
        collectionView.bounces = false
        collectionView.scrollsToTop = false
        
        
        // 设置 collectionView 数据源\代理为当前类
        collectionView.dataSource = self
//        collectionView.delegate = self
        
        // 注册 cell. 由于内容滚动视图没用 storyboard， 因此需要注册。
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: identify)
        
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
            parentViewController?.addChildViewController(childV)
        }
        // 添加 UICollectionView, 方便 cell 中存放控制器的 View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}


// MARK:- 遵守 UICollectionViewDataSource 协议
extension ContentView: UICollectionViewDataSource {
    
    // 设置collectionView单元格的数量
    // 每一组有多少条数据
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childVCs.count
    }
    
    // 初始化\返回集合视图的单元格
    // 每一行 cell 的显示具体内容
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath)
        
        // 设置cell内容
        // cell 有循环利用, 可能会添加多次, 因此先把之前的移除, 再添加
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }

        let childV = childVCs[indexPath.item]
        childV.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childV.view)
    
        return cell

    }
    
}

//// MARK:- 遵守 UICollectionViewDelegate 协议
//extension ContentView: UICollectionViewDelegate {
//    
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        
//        
//        
//    }
//    
//}
//











