//
//  CouponViewController.swift
//  爱鲜蜂高仿
//
//  Created by lotawei on 16/8/7.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class CouponViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "优惠广场"
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
