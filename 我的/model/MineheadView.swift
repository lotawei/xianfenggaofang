//
//  MineheadView.swift
//  爱鲜蜂高仿
//
//  Created by lotawei on 16/8/4.
//  Copyright © 2016年 lotawei. All rights reserved.
//

//当然也可以使用代理



class IconView: UIView {
    var    iconimg:UIImageView!
    var    phonenumber:UILabel!
    override  init(frame: CGRect) {
        super.init(frame:frame)
        iconimg = UIImageView(image: UIImage(named: "v2_my_avatar"))
        addSubview(iconimg)
        
        phonenumber = UILabel()
        phonenumber.text = "18482192206"
        phonenumber.font = UIFont.boldSystemFontOfSize(18)
        phonenumber.textColor = UIColor.whiteColor()
        phonenumber.textAlignment = .Center
        addSubview(phonenumber)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override  func layoutSubviews() {
           iconimg.frame = CGRectMake((width - iconimg.size.width)*0.5, 0, iconimg.size.width, iconimg.size.height)
           phonenumber.frame = CGRectMake(0, CGRectGetMaxY(iconimg.frame) + 5, width, 30)
    }
    
    
    
    
    
    
}


class MineheadView: UIImageView {
    
    let     setUpBtn:UIButton = UIButton(type: .Custom)
    
    let     iconView =  IconView()
    
    var     buttonClick:(Void  ->  Void)?
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        image  =  UIImage(named: "v2_my_avatar_bg")
        setUpBtn.setImage(UIImage(named: "v2_my_settings_icon"), forState: .Normal)
        
        setUpBtn.addTarget(self, action: #selector(setUpButtonClick), forControlEvents: .TouchUpInside)
        
        
        
        
        addSubview(setUpBtn)
        addSubview(iconView)
        
        self.userInteractionEnabled =  true
        
        
    }
    
    func setUpButtonClick()
    {
       
        buttonClick!()
    }
    convenience   init(frame: CGRect , settingButtonClick:(() ->  Void)) {
        self.init(frame:frame)
       self.buttonClick =  settingButtonClick
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override  func   layoutSubviews() {
            super.layoutSubviews()
        
            
            iconView.frame =  CGRectMake((width - 150)*0.5 , 30,IconViewHeight, IconViewHeight - 30)
        
            setUpBtn.frame = CGRectMake(width - 50, 10, 50, 50)
        
    }
    
    
    
    
    
    
    
    

}
