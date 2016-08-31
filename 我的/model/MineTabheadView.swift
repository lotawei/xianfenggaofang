//
//  MineTabheadView.swift
//  爱鲜蜂高仿
//
//  Created by lotawei on 16/8/5.
//  Copyright © 2016年 lotawei. All rights reserved.
//

//enum MineHeadViewButtonType : Int {
//    case  Order = 0
//    
//    case   Coupon = 1
//    
//    case   Message = 2
//}



protocol  HeadViewClickPro:class {
    
    
    func  clickatindex(sender:NSInteger)
    
    
}

class MineTabheadView: UIView {
    /**
     *  一个  回调   用于 外面进行点击时，调用点击事件
     */
//    var    mineHeadViewClick:((type:MineHeadViewButtonType)  -> Void )?
    
    
    
    
    
   
    
    
    
    //三个 小东西
    var  orderview:MineOrderView!
    var  coupview:MineCouponView!
    var  messageview:MineMessageView!
    private var couponNumber: UIButton?
    //两束线
    private let line1 = UIView()
    private let line2 = UIView()
    override  init(frame: CGRect) {
        super.init(frame: frame)
    
       
        
        buildUI()
        
        
    }
    /**
     
     */
    func setCouponNumer(number: Int) {
        if number > 0 && number <= 9 {
            couponNumber?.hidden = false
            couponNumber?.setTitle("\(number)", forState: .Normal)
        } else if number > 9 && number < 100 {
            couponNumber?.setTitle("\(number)", forState: .Normal)
            couponNumber?.hidden = false
        } else {
            couponNumber?.hidden = true
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.whiteColor()
        let subViewW = width / 3.0
        orderview.frame = CGRectMake(0, 0, subViewW, height)
 
        coupview.frame = CGRectMake(subViewW, 0, subViewW, height)
      
        messageview.frame = CGRectMake(subViewW * 2, 0, subViewW, height)
      
        couponNumber?.frame = CGRectMake(subViewW * 1.56, 12, 15, 15)
        line1.frame = CGRectMake(subViewW - 0.5, height * 0.2, 1, height * 0.6)
        line2.frame = CGRectMake(subViewW * 2 - 0.5, height * 0.2, 1, height * 0.6)
    }
    func buildUI()  {
        orderview = MineOrderView()
        
        addSubview(orderview)
        coupview = MineCouponView()
        addSubview(coupview)
        
        messageview = MineMessageView()
        addSubview(messageview)
        
        
        line1.backgroundColor = UIColor.grayColor()
        line1.alpha = 0.3
        addSubview(line1)
        
        line2.backgroundColor = UIColor.grayColor()
        line2.alpha = 0.3
        addSubview(line2)
        
        couponNumber = UIButton(type:.Custom)
        couponNumber?.setBackgroundImage(UIImage(named: "redCycle"), forState: UIControlState.Normal)
        couponNumber?.setTitleColor(UIColor.redColor(), forState: .Normal)
        couponNumber?.userInteractionEnabled = false
        couponNumber?.titleLabel?.font = UIFont.systemFontOfSize(8)
        couponNumber?.hidden = true
        setCouponNumer(1)
        addSubview(couponNumber!)
       
        
        
    
        
        
        
    
        
        
    }
  
  
    
    
   
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
}
/// san个 小东西
class    MineOrderView:UIView
{
      weak   var    delegate:HeadViewClickPro?
    var   btn:MineUpImageDownTextButton!
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
  
        btn = MineUpImageDownTextButton(frame: CGRectZero, title: "我的订单", imageName: "v2_my_order_icon")
        btn.addTarget(self, action: #selector(btnclick), forControlEvents: .TouchUpInside)
        addSubview(btn)
        
        
    }
    func btnclick()  {
        self.delegate?.clickatindex(100)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRectMake(10, 10, width - 20, height - 20)
    }
    
    
    
}
class    MineCouponView:UIView
{
   weak var   delegate:HeadViewClickPro?
    var   btn:MineUpImageDownTextButton!
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownTextButton(frame: CGRectZero, title: "优惠劵", imageName: "v2_my_coupon_icon")
       
        btn.addTarget(self, action: #selector(btnclick), forControlEvents: .TouchUpInside)
        addSubview(btn)

        
    }
    func btnclick()  {
        self.delegate?.clickatindex(101)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRectMake(10, 10, width - 20, height - 20)
    }
   
    
    
    
}
class    MineMessageView:UIView
{
    
     weak var   delegate:HeadViewClickPro?
    var   btn:MineUpImageDownTextButton!
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        btn = MineUpImageDownTextButton(frame: CGRectZero, title: "我的消息", imageName: "v2_my_message_icon")
        
        btn.addTarget(self, action: #selector(btnclick), forControlEvents: .TouchUpInside)
        addSubview(btn)
        
        
    }
    func btnclick()  {
        self.delegate?.clickatindex(102)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btn.frame = CGRectMake(10, 10, width - 20, height - 20)
    }
    
   
}










class MineUpImageDownTextButton: UpImageDownTextButton {
    init(frame: CGRect ,title:String,imageName:String)  {
        super.init(frame: frame)
        setTitle(title, forState: .Normal)
        setTitleColor(UIColor.colorWithCustom(80, g: 80, b: 80), forState: .Normal)
        setImage(UIImage(named:imageName), forState: .Normal)
        
        
        titleLabel?.font = UIFont.boldSystemFontOfSize(12)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    



}




