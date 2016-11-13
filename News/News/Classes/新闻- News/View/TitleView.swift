//
//  TitleView.swift
//  News
//
//  Created by Liu Chuan on 2016/11/11.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol TitleViewDelegate : class {
    func titleView(_ titleView : TitleView, selectedIndex index : Int)
}



// MARK:- 定义全局常量
fileprivate let colorLan = UIColor(hue:0.56, saturation:0.76, brightness:1.00, alpha:1.00)  // 全局颜色: 蓝色
private let NormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)                        // 默认状态下的颜色
private let SelectColor : (CGFloat, CGFloat, CGFloat) = (91, 192, 255)                       // 选择状态下的颜色


// MARK:标题视图
// MARK: - 定义TitleView类
class TitleView: UIView {
    
    // MARK: - 定义属性
    fileprivate var currentIndex : Int = 0          // 当前的下标值
    fileprivate var titles: [String]
    
    weak var delegate : TitleViewDelegate?
    
    
    // MARK: - 懒加载属性
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    
    fileprivate lazy var scrollView: UIScrollView = {
       
        // 创建 UIScrollView
        let scrollView = UIScrollView()
        
        // 是否显示水平指示器
        scrollView.showsHorizontalScrollIndicator = false
        
/*      scrollsToTop 是 UIScrollView 的一个属性，主要用于点击设备的状态栏时，是scrollsToTop == true的控件滚动返回至顶部。
         每一个默认的UIScrollView的实例，他的 scrollsToTop 属性默认为YES，
*/
        scrollView.scrollsToTop = false
        
        // 设置是否边缘弹动效果, 默认为true.表示开启动画，设置为false时，当滑动到边缘就是无效果
        scrollView.bounces = true
        
        return scrollView
        
    }()
    
    
    // MARK: - 底部滚动滑块
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        return scrollLine
    }()
    
    

    // MARK:- 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

// MARK:- 设置UI界面
extension TitleView {
    fileprivate func setupUI() {
        
        // 添加 UIScrollview
        addSubview(scrollView)
        scrollView.frame = bounds
        
        // 添加title对应的Label
        setUpTitleLabels()
        
        // 设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
        
        
    }
    
    
    // MARK:- 分类底部滑块\长线
    fileprivate func setupBottomLineAndScrollLine() {
        
/*
         // 1.添加底部长线
         let bottomLine = UIView()
         bottomLine.backgroundColor = UIColor.lightGray
         
         // 底部长线条的高度
         let lineH : CGFloat = 1.0
         //底线的 y: 标题滚动视图的高度 + 导航栏的高度 + 状态栏的高度 - 底线的高度
         bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
         addSubview(bottomLine)
*/
        // 2.添加scrollLine 底部滑块
        // 2.1.获取第一个Label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = colorLan
        
        // 2.2.设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.backgroundColor = colorLan
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - ScrollLineH, width: firstLabel.frame.width, height: ScrollLineH)
    }

    
    
    // MARK:- 设置标题栏的分类
    fileprivate func setUpTitleLabels() {
        /*
         * 临时常量\变量
         标题的个数必须和数组的个数相同"
         定义一个常量表示标题按钮的个数, 即就是数组元素的个数
         */
        let labelWidth: CGFloat = 60.0
        let labelHeight: CGFloat = frame.height - ScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            // 创建 UILabel
            let label = UILabel()
            
            // 设置UILabel 的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 15.0)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            
            // 开启lable用户交互
            label.isUserInteractionEnabled = true
            
            // 设置label的frame
            let labelX: CGFloat = labelWidth * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
            
            // 给Label添加手势点击事件
            label.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(labelClick(_:))))
            
            //将label添加到titleView中
            scrollView.addSubview(label)
            
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
        
        // 设置 (标题\内容) 滚动视图的滚动范围
        scrollView.contentSize = CGSize(width: titles.count * Int(labelWidth), height: 0)
        
        // contentScrollView.contentSize = CGSize(width: titleArray.count * Int(screenW), height: 0)
        
        
        
    }

}

//MARK:- 监听顶部 label手势点击事件
extension TitleView {
    
    @objc fileprivate func labelClick(_ tap: UITapGestureRecognizer) {
        
    
        
        print(tap.view!)
        
        // MARK: - 标题居中
        // 本质: 修改 标题滚动视图 的偏移量
        // 偏移量 = label 的中心 X 减去屏幕宽度的一半
        
        // 获取当前 label
        let index = tap.view as? UILabel
        
        var offset: CGPoint = scrollView.contentOffset
        offset.x = (index?.center.x)! - screenW * 0.5
        
        // 最大的偏移量 = scrollView的宽度 减去 屏幕的宽度
        let offsetMax = scrollView.contentSize.width - screenW
        
        // 如果偏移量小于0, 就不居中, 而且如果偏移量 小于最大偏移量, 让偏移量 = 最大偏移量, 从而实现不居中
        // 左边超出处理
        if offset.x < 0  {
            offset.x = 0
        } else if (offset.x > offsetMax) {  //右边超出的处理
            offset.x = offsetMax
        }
        
        
        // 滚动标题,带动画
        scrollView.setContentOffset(offset, animated: true)
        
        // 获取当前 label
        guard let currentLabel = tap.view as? UILabel else { return }
        
        // 如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == currentIndex { return }
        
        // 获取之前的 label
        let oldLabel = titleLabels[currentIndex]
        
        //MARK:- 切换文字的颜色
        currentLabel.textColor = colorLan
        oldLabel.textColor = UIColor.darkGray
        
        //MARK:- 标题字体缩放: 通过改变label的大小
        // CGAffineTransformMakeScale : 设置缩放比例. 仅通过设置缩放比例就可实现视图扑面而来和缩进频幕的效果。
        // label缩放的同时添加动画
        UIView.animate(withDuration: 0.3) {
            currentLabel.transform =  CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
        
        UIView.animate(withDuration: 0.3) {
            // 还原缩放大小
            oldLabel.transform = CGAffineTransform.identity
        }
        // 保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        // 改变滚动条的位置
        // 底部滑块的 X 值: 当前下标值 * 底部滑块的宽度
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        //给滑块添加动画
        UIView.animate(withDuration: 0.3) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
    
        // 6.通知代理
        delegate?.titleView(self, selectedIndex: currentIndex)
    }

}

// MARK:- 对外暴露的方法
extension TitleView : UIScrollViewDelegate{
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (SelectColor.0 - NormalColor.0, SelectColor.1 - NormalColor.1, SelectColor.2 - NormalColor.2)

        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(red: SelectColor.0 - colorDelta.0 * progress, green: SelectColor.1 - colorDelta.1 * progress, blue: SelectColor.2 - colorDelta.2 * progress)

        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(red: NormalColor.0 + colorDelta.0 * progress, green: NormalColor.1 + colorDelta.1 * progress, blue: NormalColor.2 + colorDelta.2 * progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
        
        //: ------------------
        
        func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        // label缩放的同时添加动画
        UIView.animate(withDuration: 0.3) {
            targetLabel.transform =  CGAffineTransform(scaleX: 1.2, y: 1.2)
            
        }
        
        UIView.animate(withDuration: 0.3) {
            // 还原缩放大小
            sourceLabel.transform = CGAffineTransform.identity
        }
    }
        
//        // 2.滚动正确的位置
//        let offsetX = CGFloat(targetIndex) * (TitleView.frame.width)
//        
//        TitleView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
//
        
        // MARK: - 标题居中
        // 本质: 修改 标题滚动视图 的偏移量
        // 偏移量 = label 的中心 X 减去屏幕宽度的一半
        
        // 获取之前的 label
//        let old_Label = titleLabels[currentIndex]
        
        var offset: CGPoint = scrollView.contentOffset
        offset.x = targetLabel.center.x - screenW * 0.5
        
        // 最大的偏移量 = scrollView的宽度 减去 屏幕的宽度
        let offsetMax = scrollView.contentSize.width - screenW
        
        // 如果偏移量小于0, 就不居中, 而且如果偏移量 小于最大偏移量, 让偏移量 = 最大偏移量, 从而实现不居中
        // 左边超出处理
        if offset.x < 0  {
            offset.x = 0
        } else if (offset.x > offsetMax) {  //右边超出的处理
            offset.x = offsetMax
        }
        
        
        // 滚动标题,带动画
        scrollView.setContentOffset(offset, animated: true)
        
    }
}


