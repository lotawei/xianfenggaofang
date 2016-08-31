//
//  MainTabBarController.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/13.
//  Copyright © 2016年 lotawei. All rights reserved.
//


class MainTabBarController: AnimationTabBarController, UITabBarControllerDelegate {
    
    private var fristLoadMainTabBarController: Bool = true
    private var adImageView: UIImageView?
    var adImage: UIImage? {
        didSet {
            print("进来")
            weak var tmpSelf = self
            adImageView = UIImageView(frame: ScreenBounds)
            adImageView!.image = adImage!
            self.view.addSubview(adImageView!)
            
            UIImageView.animateWithDuration(1.0, animations: { () -> Void in
                tmpSelf!.adImageView!.transform = CGAffineTransformMakeScale(1.2, 1.2)
                tmpSelf!.adImageView!.alpha = 0
            }) { (finsch) -> Void in
                tmpSelf!.adImageView!.removeFromSuperview()
                tmpSelf!.adImageView = nil
            }
        }
    }
    
    // MARK:- view life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        buildMainTabBarChildViewController()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if fristLoadMainTabBarController {
            let containers = createViewContainers()
            
            createCustomIcons(containers)
            fristLoadMainTabBarController = false
        }
    }
    
    // MARK: - Method
    // MARK: 初始化tabbar
    private func buildMainTabBarChildViewController() {
       
        tabBarControllerAddChildViewController(HomeViewController(), title: "首页", imagename: "v2_home", selectimagename: "v2_home_r", tag: 0)
        tabBarControllerAddChildViewController(SupermarketViewController(), title: "闪电超市", imagename: "v2_order", selectimagename: "v2_order_r", tag: 1)
        tabBarControllerAddChildViewController(ShopCartViewController(), title: "购物车", imagename: "shopCart", selectimagename: "shopCart", tag: 2)
        tabBarControllerAddChildViewController(MineViewController(), title: "我的", imagename: "v2_my", selectimagename: "v2_my_r", tag: 3)
         print(self.viewControllers?.count)
        
    }
    
   
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        let childArr = tabBarController.childViewControllers as NSArray
        let index = childArr.indexOfObject(viewController)
        
        if index == 2 {
            return false
        }
        
        return true
    }
}
extension   MainTabBarController{
    func tabBarControllerAddChildViewController(childView: UIViewController, title: String, imagename: String, selectimagename: String, tag: Int)
    {
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imagename), selectedImage: UIImage(named: selectimagename))
        vcItem.tag = tag
        /**
         *  设置            动画效果
         
         *
         *  @param rootViewController:childView
         *
         *  @return   有旋转  弹跳  翻转
         */
        
        vcItem.animation = RAMFlipTopTransitionItemAnimations()
        childView.tabBarItem = vcItem
        
        let navigationVC = BaseNavigationController(rootViewController:childView)
        addChildViewController(navigationVC)
    }
}


