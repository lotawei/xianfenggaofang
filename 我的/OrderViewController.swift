//
//  OrderViewController.swift
//  爱鲜蜂高仿
//
//  Created by lotawei on 16/8/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class OrderViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "我的订单"
        
      
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    

}
