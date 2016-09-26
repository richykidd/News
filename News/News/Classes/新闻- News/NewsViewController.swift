//
//  NewsViewController.swift
//  News
//
//  Created by Liu Chuan on 16/8/10.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    // MARK: - 属性
    @IBOutlet weak var titleScrollView: UIScrollView!
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    var selectedButton = UIButton()     // 上一次选中的按钮
    var titleButton = UIButton()        // 标题按钮
    var titleArray = [String]()
    var titleNewArray = [String]()
    var underlineX: CGFloat = 0.0       // 下划线的x轴距离
    var underlineWidth: CGFloat = 0.0   // 下划线的宽度
   
    let screenW = UIScreen.main.bounds.width
    let screenH = UIScreen.main.bounds.height
    let statusH: CGFloat = 20           // 状态栏的高度
    let navigationH: CGFloat = 44       // 导航栏的高度
    
    
    
    
    // 蓝色
    let colorLan = UIColor(hue:0.56, saturation:0.76, brightness:1.00, alpha:1.00)
    //var indicatorView = UIView(frame: CGRect(x: 0, y: -25, width: 46, height: 2))        // 标题滚动视图底部的红色指示器

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleArray = ["头条", "精选", "娱乐", "手机","体育", "视频", "财经", "汽车","军事", "房产", "健康", "彩票", "搞笑"]
        
        titleNewArray = titleArray
        
        // iOS7以后, 导航控制器中ScrollView顶部会添加 64 的额外高度
        automaticallyAdjustsScrollViewInsets = false
        
        titleScrollView.scrollsToTop = false
        
        // 设置导航栏背景色
        navigationController?.navigationBar.barTintColor = colorLan
        
        // 设置标题滚动视图的的所有标题
        AllTitle()
  
        //设置导航栏LOGO
        setupTitleLogo()
        
//        setupIndicatorView()
   
//    // MARK: - 标题滚动视图底部的红色指示器
//    func setupIndicatorView() {
//        
//        indicatorView.backgroundColor = UIColor.red
//        /// 首页顶部标签指示条的高度
//        
//       indicatorView.frame.origin.y = 35 - 2.0
//        
//        indicatorView.tag = -1
//        
//        
    }

    
    // MARK: - 设置导航栏LOGO
    func setupTitleLogo() {
        
        let myTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        let images = UIImage(named: "home_nav_title")
        let imageView = UIImageView(image: images)
        imageView.frame = CGRect(x: (120 - 45) / 2, y: (30 - 23) / 2, width: 50, height: 30)
        myTitleView.addSubview(imageView)
        navigationItem.titleView = myTitleView
    }

    // MARK: - 设置标题滚动视图的的所有标题
    func AllTitle() {
        /*
         * 临时常量\变量
            标题的个数必须和数组的个数相同"
            定义一个常量表示标题按钮的个数, 即就是所有数组的个数
         */
    
        let count = titleArray.count
        let btnWidth: CGFloat = 50.0
        let btnHeight = titleScrollView.frame.size.height
 
        for i in 0 ..< count {
            
            let btnX:CGFloat = CGFloat(i) * btnWidth
            
            titleButton = UIButton(type: UIButtonType.system)
            titleButton.setTitle(titleArray[i], for: UIControlState.normal)
            titleButton.frame = CGRect(x: btnX, y: 0, width: btnWidth, height: btnHeight)
            titleButton.setTitleColor(UIColor.black, for: UIControlState.normal)
           
            // 监听标题按钮的点击
            titleButton.addTarget(self, action: #selector(titleButtonClick(button:)), for: UIControlEvents.touchUpInside)
            titleButton.tag = i
            
            // 把标题按钮保存到新的数组里面
           // self.titleNewArray.append(titleArray)
            
//            if i % 2 == 0 {
                // 添加子控制器
                let head = HeadlineViewController()
                head.index = i
                head.view.frame = CGRect(x: CGFloat(i) * screenW, y: 0, width: screenW, height: screenH - 108)
                addChildViewController(head)
                contentScrollView.addSubview(head.view)
            
//            } else {
                let happy = HappyViewController()
                happy.index = i
                happy.view.frame = CGRect(x: CGFloat(i) * screenW, y: 0, width: screenW, height: screenH - 108)
                addChildViewController(happy)
                contentScrollView.addSubview(happy.view)

//            }
            
            // 判断, 如果标题为0 默认显示第一个
            if i == 0 {
                self.titleButtonClick(button: titleButton)
                
            }
            
            titleScrollView.addSubview(titleButton)
//            titleScrollView.addSubview(indicatorView)
            
        }
        
        // 设置标题滚动视图的内容尺寸
        titleScrollView.contentSize = CGSize(width: titleArray.count * Int(btnWidth), height: 0)
        
        // 设置内容滚动视图的内容尺寸
        //contentSize的宽度等于顶部滑动栏的item个数乘与屏幕宽度screenW
        //  contentScrollView.contentSize = CGSize(width: count * Int(screenW), height: Int(screenH) - 108)
        contentScrollView.contentSize = CGSize(width: count * Int(contentScrollView.frame.width), height: 0)
        
        }

    // MARK: - 处理标题按钮的点击事件
    func titleButtonClick(button: UIButton) {
        
        // 选中标题
        self.selectedBtn(button: button)
        
        // 通过 button 的 tag 取出对应的标题\子控制器
        let z = button.tag
        
//        print("items is \(z)")
        
        // 把对应的子控制器的 view 添加上去
        let vc: UIViewController = childViewControllers[z]
        
        //let x: CGFloat = CGFloat(z) * contentScrollView.frame.width
        let x = contentScrollView.contentOffset.x
        vc.view.frame = CGRect(x: x, y: 0, width: screenW, height: contentScrollView.frame.height)
        
        contentScrollView.addSubview(vc.view)
        
        
        // 内容滚动视图的 - 偏移量
//        contentScrollView.contentOffset = CGPoint(x: x, y: 0)
        //带动画
        contentScrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
        
    }
    // MARK: - 选中标题
    func selectedBtn(button: UIButton) {
    
        // 点击标题按钮, 改变标题按钮文字颜色
        button.setTitleColor(colorLan, for: UIControlState.normal)
        // 设置上一次选中的按钮的颜色
        selectedButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        
        // 还原缩放大小
        selectedButton.transform = CGAffineTransform.identity
        
        // - 标题居中
        // 本质: 修改 titleScollview 的偏移量
        // 偏移量 = 按钮的中心 X 减去屏幕宽度的一半
        var offsetX = button.center.x - screenW * 0.5
        
        // 最大的偏移量 = titleScrollView的宽度 减去 屏幕的宽度
        let offsetMax = titleScrollView.contentSize.width - screenW
        
        // 如果偏移量小于0, 就不居中, 而且如果偏移量 小于最大偏移量, 让偏移量 = 最大偏移量, 从而实现不居中
        if offsetX < 0 {
            offsetX = 0
        } else if (offsetX > offsetMax) {
            offsetX = offsetMax
        }
        
        // 滚动标题,带动画
        titleScrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        // - 标题字体缩放: 通过改变按钮的大小
        button.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        // 上一次选中的按钮就等于当前按钮
        selectedButton = button
        
    }

    // MARK: - UIScrollViewDelegate的代理方法
    // 滚动完成时调用
 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        // 获取当前角标
        let i = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        print("item is \(i)")
        
        // 获取标题按钮
        let titleBtns = titleScrollView.subviews[i] as! UIButton
        
        // 选中标题按钮
        self.selectedBtn(button: titleBtns)
        
        // 把对应的子控制器的 view 添加上去
        let vc: UIViewController = childViewControllers[i]
       
        let x = scrollView.contentOffset.x
        vc.view.frame = CGRect(x: x, y: 0, width: screenW, height: contentScrollView.frame.height)
        
        contentScrollView.addSubview(vc.view)
        
    }
    
    // MARK: - 只要一滚动, 就调用
    //字体的缩放比例
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 字体缩放 1.缩放比例 2.缩放哪个按钮
        // 获取角标: 偏移量除以 屏幕的宽度
        let LeftI = scrollView.contentOffset.x / screenW
        let RightI = Int(LeftI + 1)
        
        // 获取左边的按钮
        let leftButton = titleScrollView.subviews[Int(LeftI)] as! UIButton
       // let count = self.childViewControllers.count
        let count = titleArray.count

        // 获取右边的按钮
        var RightButton = UIButton()
        if RightI < count {
            RightButton = titleScrollView.subviews[RightI] as! UIButton
        }
        
        // 缩放比例
        // 0 ~ 1
        
        // 右边按钮缩放比例
        var ZoomRight = scrollView.contentOffset.x / screenW
        ZoomRight -= LeftI
        
        // 左边边按钮缩放比例
        let ZoomLeft = 1 - ZoomRight
        
        // 缩放按钮
        leftButton.transform = CGAffineTransform(scaleX: ZoomLeft * 0.3 + 1, y: ZoomLeft * 0.3 + 1)
        RightButton.transform = CGAffineTransform(scaleX: ZoomRight * 0.3 + 1, y: ZoomRight * 0.3 + 1)
        
        //        leftButton.transform = CGAffineTransform(translationX: ZoomLeft * 0.3 + 1, y: ZoomLeft * 0.3 + 1)
        //        RightButton.transform = CGAffineTransform(translationX: ZoomRight * 0.3 + 1, y: ZoomRight * 0.3 + 1)
        
        
        
        // - 字体颜色渐变
        // 左\右俩边的颜色
//        let LeftColor = UIColor(colorLiteralRed: Float(ZoomLeft), green: 0.73, blue: 1, alpha: 1)
//        let RightColor = UIColor(colorLiteralRed: Float(ZoomRight), green: 0.73, blue: 1, alpha: 1)

        //UIColor(red:0.24, green:0.73, blue:1.00, alpha:1.00)
        
//        leftButton.setTitleColor(LeftColor, for: UIControlState.normal)
//        RightButton.setTitleColor(RightColor, for: UIControlState.normal)
        
        /*
         颜色: 3种颜色通道组成: R:红 G:绿 B:蓝
         白色: 1 1 1
         黑色: 0 0 0
         红色: 1 0 0
         */
    }
    
    // 修改状态栏的颜色位白色.默认是黑色
//    override func preferredStatusBarStyle() -> UIStatusBarStyle {
//        
//        return UIStatusBarStyle.lightContent
//    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }


}
