//
//  MineViewController.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/16.
//  Copyright © 2016年 lotawei. All rights reserved.
//




/// 思想：   界面的 所有 view   你要想着  可以 复用   因此都不会直接用原来的 控件

/// 如本届面的 headView  和 tableview 都是继承 一个系统基类来改装



/// 首页  内容

class MineViewController: BaseViewController{
    
    /**
     *  上面  部分   mineheadview
     
     */
    private   var    mineheadview:MineheadView!
    private   var    tableview:LFBTableView!
    
    private  var    tableheadview:MineTabheadView!
    
    //cell   数据源
    private  lazy var mines: [MineCellModel] = {
        let mines = MineCellModel.loadMineCellModels()
        return mines
    }()
    
    
    
    override   func   viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
    }
    override func viewDidLoad() {
        /**
         *   头部 最上方*/
        
        
        super.viewDidLoad()
        
        buildUI()
        
        let   _    =   self.mines
        
        
        tableview.reloadData()
        
    }
    /**
     最上方
     */
    func buildUI()   {
        
        weak   var  temlpself = self
        mineheadview = MineheadView(frame: CGRectMake(0, 0, ScreenWidth, HeadViewHeight), settingButtonClick: {
            ()  ->  Void  in
            
            let settingVc = SettingViewController()
            temlpself!.navigationController?.pushViewController(settingVc, animated: true)
            
            
            
        })
        
        
        
        self.view.addSubview(mineheadview)
        
        
        //建立表视图 头部
        buildTabHeadView()
        
        
        
    }
    
    
    private  func   buildTabHeadView()
    {
        tableview = LFBTableView(frame: CGRectMake(0, HeadViewHeight, ScreenWidth, ScreenHeight - HeadViewHeight), style: .Grouped)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.rowHeight = 46
        view.addSubview(tableview)
        
        tableheadview = MineTabheadView(frame: CGRectMake(0,CGRectGetMaxY(mineheadview.frame) + 20,ScreenWidth,70))
        tableheadview.backgroundColor =  UIColor.whiteColor()
        
        tableheadview.orderview.delegate = self
        tableheadview.coupview.delegate = self
        tableheadview.messageview.delegate = self
        tableheadview.backgroundColor = UIColor.whiteColor()
        
        self.tableview.tableHeaderView = tableheadview
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    
}


extension   MineViewController:UITableViewDelegate, UITableViewDataSource , HeadViewClickPro
{
    
    //这里不调用
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let   cell =  MineCell.cellFor(tableView)
        
        
        if 0 == indexPath.section {
            cell.mineModel  = self.mines[indexPath.row]
        } else if (1 == indexPath.section) {
            cell.mineModel  = self.mines[2]
        } else {
            if indexPath.row == 0  {
                cell.mineModel  = self.mines[3]
            }
            else{
                cell.mineModel  = self.mines[4]
                
            }
            
        }
        return   cell
    }
    
    
    //每一组的 行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if 0 == section {
            return 2
        } else if (1 == section) {
            return 1
        } else {
            return 2
        }
        
    }
    
    //
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return    3
    }
    
    
    
    
    
    
    //选择进入的控制器
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if 0 == indexPath.section {
            if 0 == indexPath.row {
                let adressVC = MyAdressViewController()
                navigationController?.pushViewController(adressVC, animated: true)
            } else {
                let myShopVC = MyShopViewController()
                navigationController?.pushViewController(myShopVC, animated: true)
            }
        } else if 1 == indexPath.section {
            //            shareActionSheet.showActionSheetViewShowInView(view) { (shareType) -> () in
            //                ShareManager.shareToShareType(shareType, vc: self)
        }
        else if 2 == indexPath.section {
            if 0 == indexPath.row {
                let helpVc = HelpViewController()
                navigationController?.pushViewController(helpVc, animated: true)
            } else if 1 == indexPath.row {
                //                let ideaVC = IdeaViewController()
                //                ideaVC.mineVC = self
                //                navigationController!.pushViewController(ideaVC, animated: true)
            }
        }
        
        
    }
    
    
    
    //       三个 界面
    func clickatindex(sender: Int) {
        
        
        
        switch sender {
        case   100:
            let   orderviewcontroller = OrderViewController()
            self.navigationController?.pushViewController(orderviewcontroller, animated: true)
            
            break
        case   101:
            let   couviewcontroller = CouponViewController()
            self.navigationController?.pushViewController(couviewcontroller, animated: true)
            break
        case   102:
            let   msgviewcontroller = MessageViewController()
            self.navigationController?.pushViewController(msgviewcontroller, animated: true)
            break
        default:
            
            break
        }
        
        
        
        
    }
    
    
    
}
