//
//  Apple_ViewController.swift
//  News
//
//  Created by Liu Chuan on 2016/11/16.
//  Copyright © 2016年 LC. All rights reserved.
//

import UIKit
// MARK:- 定义全局常量
private let identify = "cell"

private let RefreshHeight: CGFloat = 200

class Apple_ViewController: BaseViewController {
    
    
    // MARK: - 刷新视图
    fileprivate var refreshView: RefreshView!
    
    
    // MARK: 懒加载属性
    fileprivate lazy var newsModels: [NewsModel] = [NewsModel]()
    
    // MARK: 懒加载控件 tableView
    fileprivate lazy var tableView: UITableView = {[unowned self] in
        
        // 创建 UItableView
        let tableView = UITableView()
        
        // 设置 UItableView 相关属性
        //tableView.frame = self.view.bounds
         tableView.frame = CGRect(x: 0, y: 0, width: Int(self.view.bounds.width), height: Int(screenH - statusH - navigationH - titleViewH - ScrollLineH - tabBarH))
        tableView.dataSource = self
        tableView.rowHeight = 90
        
        // 注册 cell
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: identify)
        tableView.register(UINib(nibName: "AppleViewCell", bundle: nil), forCellReuseIdentifier: identify)
        
        return tableView
        
        
        }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // 设置刷新视图
//        setupRefreshView()
        refreshView = RefreshView(frame: CGRect(x: 0, y: -RefreshHeight, width: view.bounds.width, height: RefreshHeight), scrollView: tableView)
        refreshView.backgroundColor = UIColor.red
        
      //  view.insertSubview(refreshView, at: 0)
        view.addSubview(refreshView)

        
        // 添加 UItableView
        view.addSubview(tableView)
        
        // 请求数据
        loadData()
        
    }

    // MARK: - 设置刷新视图
    fileprivate func setupRefreshView() {
//        refreshView = RefreshView(frame: CGRect(x: 0, y: -RefreshHeight, width: view.bounds.width, height: RefreshHeight ), scrollView: tableView)
        
        refreshView = RefreshView(frame: CGRect(x: 0, y: -RefreshHeight, width: view.bounds.width, height: RefreshHeight), scrollView: tableView)
        
        refreshView.backgroundColor = UIColor.red
        
        view.insertSubview(refreshView, at: 0)
    }
    
    
    
}




// MARK:- 网络数据的请求
extension Apple_ViewController {
    fileprivate func loadData() {
        NetworkTool.requsetData("http://c.m.163.com/nc/article/list/T1348649580692/0-20.html", type: .get)
        { (result: Any) in
            
            print(result)
            
            // 将 Any 类型转换成字典类型
            guard let resultDictionary = result as? [String : Any] else { return }
            
            // 根据 T1348649079062 的key 取出内容
            guard let dataArray = resultDictionary["T1348649580692"] as? [[String : Any]] else { return }
            
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
extension Apple_ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 获取 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: identify, for: indexPath) as! AppleViewCell
        
        // 设置 cell 数据
        //cell.textLabel?.text = newsModels[indexPath.row].title
        cell.newModel = newsModels[indexPath.row]
        
        
        // 返回 cell
        return cell
        
    }
    
}

