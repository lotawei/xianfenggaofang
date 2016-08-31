//
//  ShopCartSupermarketTableFooterView.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/18.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class ShopCartSupermarketTableFooterView: UIView {
    
    private let titleLabel      = UILabel()
    let priceLabel              = UILabel()
    private let determineButton = UIButton()
    private let backView        = UIView()
    weak var delegate: ShopCartSupermarketTableFooterViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backView.frame = CGRectMake(0, 0, ScreenWidth, ShopCartRowHeight)
        backView.backgroundColor = UIColor.whiteColor()
        addSubview(backView)
        
        titleLabel.text = "共$ "
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.redColor()
        titleLabel.frame = CGRectMake(15, 0, titleLabel.width, ShopCartRowHeight)
        addSubview(titleLabel)
        
        priceLabel.font = UIFont.systemFontOfSize(14)
        priceLabel.textColor = UIColor.redColor()
        priceLabel.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame), 0, ScreenWidth * 0.5, ShopCartRowHeight)
        priceLabel.text = UserShopCarTool.sharedUserShopCar.getAllProductsPrice()
        addSubview(priceLabel)
        
        determineButton.frame = CGRectMake(ScreenWidth - 90, 0, 90, ShopCartRowHeight)
        determineButton.backgroundColor = LFBNavigationYellowColor
        determineButton.setTitle("选好了", forState: UIControlState.Normal)
        determineButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        determineButton.titleLabel?.font = UIFont.systemFontOfSize(14)
        determineButton.addTarget(self, action: #selector(ShopCartSupermarketTableFooterView.determineButtonClick), forControlEvents: .TouchUpInside)
        addSubview(determineButton)
        
        addSubview(lineView(CGRectMake(0, ShopCartRowHeight - 0.5, ScreenWidth, 0.5)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPriceLabel(price: Double) {
        priceLabel.text = "\(price)".cleanDecimalPointZear()
    }
    
    private func lineView(frame: CGRect) -> UIView {
        let lineView = UIView(frame: frame)
        lineView.backgroundColor = UIColor.blackColor()
        lineView.alpha = 0.1
        return lineView
    }
    
    func determineButtonClick() {
        delegate?.supermarketTableFooterDetermineButtonClick()
    }
}

protocol ShopCartSupermarketTableFooterViewDelegate: NSObjectProtocol {
    
    func supermarketTableFooterDetermineButtonClick();
}
