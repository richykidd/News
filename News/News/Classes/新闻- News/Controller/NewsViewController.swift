//
//  NewsViewController.swift
//  News
//
//  Created by Liu Chuan on 2016/9/25.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

// MARK:- 定义全局常量
//private let titleViewH: CGFloat = 44         // 标题滚动视图的高度
private let colorLan = UIColor(hue:0.56, saturation:0.76, brightness:1.00, alpha:1.00)  //全局颜色: 蓝色

class NewsViewController: UIViewController {
    
    // MARK:- 懒加载属性
    
    // ==================
    // MARK: 标题滚动视图
    // ==================
    fileprivate lazy var titleView : TitleView = {[weak self] in
       
        // 标题滚动视图Y值: 状态栏高度 + 导航栏高度
        let titleFrame = CGRect(x: 0, y: statusH + navigationH, width: screenW, height: titleViewH)
        let titlesArray = ["头条", "数码", "娱乐", "手机","体育", "视频", "财经", "汽车","军事", "时尚", "健康", "彩票", "搞笑"]
        
        // 频道列表没从网上获取，直接用了网易新闻bundle里的这个文件。
//        let url: NSURL = Bundle.main.url(forResource: "topic_news.json", withExtension: nil)! as NSURL
//        print(url)
//        
//        let data = NSData(contentsOf: url as URL)
//        
//        do {
//            
//            let dict: [NSObject : AnyObject] = try JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions(rawValue: 0))
//            
//        } catch {
//            let array: [AnyObject] = dict["tList"]
//            let arrayM: NSMutableArray = NSMutableArray.withCapacity(array.count)
//            
//        }
        
        //1 获取json文件路径
        //let path = Bundle.main.path(forResource: "data", ofType: "json")

        let title_View = TitleView(frame: titleFrame, titles: titlesArray)
        
        title_View.delegate = self
        
        return title_View
    }()
    
    // ==================
    // MARK: 内容滚动视图
    // ==================
    fileprivate lazy var contentView : ContentView = {[weak self] in
        
        // 1.确定内容的frame
        // contentH = 屏幕高度 - 状态栏高度 - 导航栏高度 - 标题滚动视图高度 - 底部线条的高度 - 标签栏的高度
        let contentH = screenH - statusH - navigationH - titleViewH - ScrollLineH - tabBarH
        let contentFrame = CGRect(x: 0, y: statusH + navigationH + titleViewH, width: screenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(HeadlineViewController())
        childVcs.append(Apple_ViewController())
        
        for _ in 0 ..< 11 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            
            childVcs.append(vc)
        }
        
        let content_View = ContentView(frame: contentFrame, childVCs: childVcs, parentViewController: self!)
        content_View.delegate = self
        return content_View
        
        }()
    
 
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置UI界面
        setupUI()
        
        }
    
    }
    
// MARK:- 设置UI界面
extension NewsViewController {
    
    fileprivate func setupUI() {
        
        // iOS7以后, 导航控制器中ScrollView顶部会添加 64 的额外高度
        automaticallyAdjustsScrollViewInsets = false
        
        // 设置导航栏
        setupNavigationColorAndLogo()
       
        // 添加TitleView
        view.addSubview(titleView)
        
        // 添加ContentView
        view.addSubview(contentView)
        
    }

    // MARK: - 设置导航栏
    fileprivate func setupNavigationColorAndLogo() {
    
        // 设置导航栏背景色
        navigationController?.navigationBar.barTintColor = colorLan
        // 修改导航栏文字颜色
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
   
        // 设置导航栏LOGO
        let myTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        
        let imageView = UIImageView(image: UIImage(named: "home_nav_title"))
        
        imageView.frame = CGRect(x: (120 - 45) / 2, y: (30 - 23) / 2, width: 50, height: 30)
        
        myTitleView.addSubview(imageView)
        
        navigationItem.titleView = myTitleView
    }

}
  
// MARK:- 遵守PageTitleViewDelegate协议
extension NewsViewController : TitleViewDelegate {
    func titleView(_ titleView: TitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}



// MARK:- 遵守PageContentViewDelegate协议
extension NewsViewController : ContentViewDelegate {
    func contentView(_ contentView: ContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        titleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
}

