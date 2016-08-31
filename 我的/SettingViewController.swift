//
//  SettingViewController.swift
//  爱鲜蜂高仿
//
//  Created by lotawei on 16/8/5.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class SettingViewController: BaseViewController {
    
    /**
     
     
     - parameter animated: 四个  view  未使用tableview
     */
    private    let    subheight :CGFloat =  50
    
    private    var  aboutmeview:UIView!
    private    var  cleancacheview:UIView!
    private    var  cachenumberlabel:UILabel!
    private   var   logoutview:UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setcleanCache()
        setLoginout()
        
        
    }
    
    
    override  func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
             self.navigationController?.setNavigationBarHidden(false, animated: true)

        
        
    }
    
    
    
    func abouttap()  {
        print("关于我")
    }
    
    
   func  setUpUI()
   {
    self.navigationItem.title = "设置"
   
    aboutmeview =  UIView(frame:CGRectMake(0,0,ScreenWidth,subheight))
      aboutmeview.backgroundColor = UIColor.whiteColor()
     let   textlable = UILabel(frame: CGRectMake(20 , 0 , 100, 50))
    
    aboutmeview.userInteractionEnabled =  true
    textlable.text  = "关于爱鲜蜂"
      textlable.font = UIFont.systemFontOfSize(16)
    aboutmeview.addSubview(textlable)
   
    
    let   arroimg = UIImageView(image: UIImage(named: "icon_go"))
    
    arroimg.frame =  CGRectMake(aboutmeview.width - 20, (aboutmeview.height -  10)*0.5, 5, 10)
    
    aboutmeview.addSubview(arroimg)
        
    
    
    
    let   atap =   UITapGestureRecognizer(target: self, action: #selector(abouttap))
    
    aboutmeview.addGestureRecognizer(atap)
    
    
    
    self.view.addSubview(aboutmeview)
    
    }
    func setcleanCache()  {
        cleancacheview = UIView(frame: CGRectMake(0,CGRectGetMaxY(aboutmeview.frame),ScreenWidth,subheight))
        cleancacheview.backgroundColor =  UIColor.whiteColor()
        let   textlable = UILabel(frame:CGRectMake(20,0,100,50))
        textlable.font = UIFont.systemFontOfSize(16)
        textlable.text = "清理缓存"
        cleancacheview.addSubview(textlable)
        
        cleancacheview.userInteractionEnabled =  true
        
        cachenumberlabel = UILabel(frame:CGRectMake((cleancacheview.width - 40 ),(cleancacheview.height - 40)*0.5 ,40,40))
        cachenumberlabel.adjustsFontSizeToFitWidth = true
        cachenumberlabel.minimumScaleFactor = 0.3
        cachenumberlabel.font = UIFont.systemFontOfSize(16)

        cachenumberlabel.text = "0M"
        
        
        cleancacheview.addSubview(cachenumberlabel)
        
        
        
        let   atap =   UITapGestureRecognizer(target: self, action: #selector(cleanCahce))
        
        cleancacheview.addGestureRecognizer(atap)
        
        
        
        
        
        self.view.addSubview(cleancacheview)
    }
    func  cleanCahce()  {
        print("清理缓存")
    }
    
   func  setLoginout()
   {
    logoutview  =   UIView(frame:CGRectMake(0,CGRectGetMaxY(cleancacheview.frame) +  30,ScreenWidth,subheight))
    logoutview.backgroundColor = UIColor.whiteColor()
    let   loginoutbtn = UIButton(frame:CGRectMake((ScreenWidth - 200)*0.5,0,200,50))
    loginoutbtn.setTitle("退出当前账号", forState: .Normal)
     logoutview.addSubview(loginoutbtn)
    logoutview.userInteractionEnabled = true
    
    loginoutbtn.addTarget(self, action: #selector(logout), forControlEvents: .TouchUpInside)
   
   loginoutbtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
  
    self.view.addSubview(logoutview)
    
  }
    func logout()   {
        
        print("退出当前")
    }
    
}


    
    
    
    
    
    
    

