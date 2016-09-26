//
//  NewsViewController.swift
//  News
//
//  Created by Liu Chuan on 2016/9/25.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    // MARK: - 属性
    @IBOutlet weak var titleScrollView: UIScrollView!
//    @IBOutlet weak var contentScrollView: UIScrollView!

    var titleArray = [String]()
   
    // 全局颜色: 蓝色
    let colorLan = UIColor(hue:0.56, saturation:0.76, brightness:1.00, alpha:1.00)
    
//    let screenW = UIScreen.main.bounds.width
//    let screenH = UIScreen.main.bounds.height
//    let statusH: CGFloat = 20           // 状态栏的高度
//    let navigationH: CGFloat = 44       // 导航栏的高度
//    private let ScrollLineH : CGFloat = 2   // 滚动滑块的高度

    
    
    private var currentIndex: Int = 0       // 当前的索引
    private var oldLabel = UILabel()        // 点击之前的 label
    
    private let NormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
    private let SelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

    
    // MARK:- 懒加载属性
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    // 内容滚动视图
    private lazy var contentView : ContentView = {[weak self] in
        
        // 1.确定内容的frame
        // contentH = 屏幕高度 - 状态栏高度 - 导航栏高度 - 标题滚动视图高度 - 底部线条的高度
        let contentH = screenH - statusH - navigationH - titleScollViewH - ScrollLineH
        let contentFrame = CGRect(x: 0, y: statusH + navigationH + titleScollViewH, width: screenW, height: contentH)
        
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        //childVcs.append(RecommendViewController())
        
        for _ in 0..<13 {
            
            let vc = UIViewController()
            
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = ContentView(frame: contentFrame, childVCs: childVcs, parentViewController: self!)
       
        //contentView.delegate = self
        return contentView
        }()
    
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         titleArray = ["头条", "精选", "娱乐", "手机","体育", "视频", "财经", "汽车","军事", "房产", "健康", "彩票", "搞笑"]
        
        // iOS7以后, 导航控制器中ScrollView顶部会添加 64 的额外高度
        automaticallyAdjustsScrollViewInsets = false
        
       /* scrollsToTop 是 UIScrollView 的一个属性，主要用于点击设备的状态栏时，是scrollsToTop == YES 的控件滚动返回至顶部。
         每一个默认的UIScrollView的实例，他的 scrollsToTop 属性默认为YES，
        */
        titleScrollView.scrollsToTop = false

        
        // 设置是否边缘弹动效果
        // 滑动视图的边界回弹效果，默认为YES.表示开启动画，设置为NO时，当滑动到边缘就是无效果
        titleScrollView.bounces = false


        // 设置标题栏的分类
        setUpTitle()
        
        // 设置导航栏
        setupNavigationColorAndLogo()
        
        // 设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
        
        
        // 添加 contentView
        view.addSubview(contentView)
    }
    // MARK: - 设置导航栏
    private func setupNavigationColorAndLogo() {
    
        // 设置导航栏背景色
        navigationController?.navigationBar.barTintColor = colorLan
        //修改导航栏文字颜色
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
   
        // 设置导航栏LOGO
        let myTitleView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 30))
        let images = UIImage(named: "home_nav_title")
        let imageView = UIImageView(image: images)
        imageView.frame = CGRect(x: (120 - 45) / 2, y: (30 - 23) / 2, width: 50, height: 30)
        myTitleView.addSubview(imageView)
        navigationItem.titleView = myTitleView    
    }

    
    //MARK:- 底部滚动滑块 -懒加载
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        return scrollLine
    }()
    
    private func setupBottomLineAndScrollLine() {
        
/*
        // 1.添加底部长线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        
        // 底部长线条的高度
         let lineH : CGFloat = 1.0
         //底线的 y: 标题滚动视图的高度 + 导航栏的高度 + 状态栏的高度 - 底线的高度
         bottomLine.frame = CGRect(x: 0, y: titleScrollView.frame.height + navigationH + statusH - lineH, width: titleScrollView.frame.width, height: lineH)
         view.addSubview(bottomLine)
*/
        // 2.添加scrollLine 底部滑块
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        //firstLabel.textColor = colorLan
        
        // 2.2.设置scrollLine的属性
        titleScrollView.addSubview(scrollLine)
        scrollLine.backgroundColor = colorLan
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: titleScrollView.frame.height - ScrollLineH, width: firstLabel.frame.width, height: ScrollLineH)
    }

    // MARK:- 设置标题栏的分类
    func setUpTitle() {
        /*
         * 临时常量\变量
         标题的个数必须和数组的个数相同"
         定义一个常量表示标题按钮的个数, 即就是数组元素的个数
         */
        
        let scollViewLine: CGFloat = 5
        let labelWidth: CGFloat = 50.0
        let labelHeight: CGFloat = titleScrollView.frame.size.height - scollViewLine
        let labelY: CGFloat = 0
        
        
        for (index, title) in titleArray.enumerated() {
            
            // 创建 UILabel
            let label = UILabel()
            
            // 设置UILabel 的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 14.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 开启lable用户交互
            label.isUserInteractionEnabled = true
            
            // 给Label添加手势点击事件
            label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelClick(tap:))))
            
            // 设置label的frame
            let labelX: CGFloat = labelWidth * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)

            //将label添加到titleScrollView中
            titleScrollView.addSubview(label)
            
            // 将 label 加到 titleLabels 数组中
            titleLabels.append(label)
            
            // 如何标签索引为 0, 设置第一个Label颜色
            if index == 0 {
                // 获取第一个Label
                let firstLabel = titleLabels.first
                // 设置颜色
                firstLabel?.textColor = colorLan
            }
       
        }
        
         // 设置 (标题\内容) 滚动视图 的 滚动范围
        titleScrollView.contentSize = CGSize(width: titleArray.count * Int(labelWidth), height: 0)
//        contentScrollView.contentSize = CGSize(width: titleArray.count * Int(screenW), height: 0)
        
    }
    
    //MARK:- 监听顶部 label手势点击事件
    func labelClick(tap: UITapGestureRecognizer) {
        
        print(tap.view)
        
        //MARK: - 标题居中
        // 本质: 修改 titleScollview 的偏移量
        // 偏移量 = label 的中心 X 减去屏幕宽度的一半
        
        let index = tap.view as? UILabel
        
        var offset: CGPoint = titleScrollView.contentOffset
        offset.x = (index?.center.x)! - screenW * 0.5
        
        // 最大的偏移量 = titleScrollView的宽度 减去 屏幕的宽度
        let offsetMax = titleScrollView.contentSize.width - screenW
        
        // 如果偏移量小于0, 就不居中, 而且如果偏移量 小于最大偏移量, 让偏移量 = 最大偏移量, 从而实现不居中
       
        // 左边超出处理
        if offset.x < 0  {
            offset.x = 0
            
        } else if (offset.x > offsetMax) {  //右边超出的处理
            offset.x = offsetMax
        }
        
        
        // 滚动标题,带动画
//        titleScrollView.setContentOffset(CGPoint(x: offset.x, y: 0), animated: true)
        
        titleScrollView.setContentOffset(offset, animated: true)

        // 获取当前 label 的下标值
        guard let currentLabel = tap.view as? UILabel else { return }
        
        // 如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 获取之前的 label
        let oldLabel = titleLabels[currentIndex]
   
        //MARK:- 切换文字的颜色
        currentLabel.textColor = colorLan
        oldLabel.textColor = UIColor.darkGray
        
        //MARK:- 标题字体缩放: 通过改变label的大小
        currentLabel.transform =  CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        // 还原缩放大小
        oldLabel.transform = CGAffineTransform.identity
        
        // 保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 5.滚动条位置发生改变
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
    }
    
    
    
   
    
//    private func addChildVC() {
//    
//        // 添加所有子控制器
//        var childVC = [UIViewController]()
//        
//        for _ in 0 ..< titleArray.count {
//            
//            let vc = UIViewController()
//            
//            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform((UInt32(255.0)))), green: CGFloat(arc4random_uniform((UInt32(255.0)))), blue: CGFloat(arc4random_uniform((UInt32(255.0)))), alpha: CGFloat(arc4random_uniform((UInt32(255.0)))))
//            
//            childVC.append(vc)
//        }
//
//    
//    }


}





