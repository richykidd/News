//
//  HeadlineViewController.swift
//  News
//
//  Created by Liu Chuan on 16/8/4.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit


// MARK:- 定义全局常量
private let identify = "cell"


class HeadlineViewController: UIViewController {
    
    
    // MARK: 懒加载属性
    fileprivate lazy var newsModels: [NewsModel] = [NewsModel]()
    fileprivate var refreshControl = UIRefreshControl()    //刷新控件
    
  
    // MARK: 懒加载控件 tableView
    fileprivate lazy var tableView: UITableView = {[unowned self] in
        
        // 创建 UItableView
        let tableView = UITableView()
        
        // 设置 UItableView 相关属性
        tableView.frame = self.view.bounds
        tableView.dataSource = self
        tableView.rowHeight = 90
        
        // 注册 cell
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        tableView.register(UINib(nibName: "NewViewCell", bundle: nil), forCellReuseIdentifier: identify)
        
        return tableView
        
        
        }()

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加 UItableView
        view.addSubview(tableView)
        
        
        // 请求数据
        loadData()
        
    
        refreshControl = UIRefreshControl()
        
        tableView.addSubview(refreshControl)
        


        
    }

 
}

//// MARK:- 设置刷新控件
//fileprivate func  steUPRefreshControl() {
//    
//    refreshControl = UIRefreshControl()
//    
//    tableView.addSubview(refreshControl)
//    
//    
//    
//}





// MARK:- 网络数据的请求
extension HeadlineViewController {
    fileprivate func loadData() {
        NetworkTool.requsetData(URLString: "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html", type: .get)
        { (result: Any) in
            
            //print(result)
            
            // 将 Any 类型转换成字典类型
            guard let resultDictionary = result as? [String : Any] else { return }
            
            // 根据 T1348649079062 的key 取出内容
            guard let dataArray = resultDictionary["T1348647853363"] as? [[String : Any]] else { return }
            
            // 遍历字典, 将字典转换成模型对象
            for dict in dataArray {
                self.newsModels.append(NewsModel(dict: dict))
                
            }
            
            // 刷新表格
            self.tableView.reloadData()
        }
        
    }
    
}

// MARK:- 实现 UITableView 数据源协议
extension HeadlineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 获取 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! NewViewCell
        
        // 设置 cell 数据
        //cell.textLabel?.text = newsModels[indexPath.row].title
        cell.newModel = newsModels[indexPath.row]
        
        
        // 返回 cell
        return cell
        
    }
    
}
