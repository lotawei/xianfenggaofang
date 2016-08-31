//
//  IconImageTextView.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/13.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class IconImageTextView: UIView {
    
    private var imageView: UIImageView?
    private var textLabel: UILabel?
    private var placeholderImage: UIImage?
    
    var activitie: Activities? {
        didSet {
            textLabel?.text = activitie?.name
            imageView?.sd_setImageWithURL(NSURL(string: activitie!.img!)!, placeholderImage: placeholderImage)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.userInteractionEnabled = false
        imageView?.contentMode = UIViewContentMode.Center
        addSubview(imageView!)
        
        textLabel = UILabel()
        textLabel!.textAlignment = NSTextAlignment.Center
        textLabel!.font = UIFont.systemFontOfSize(12)
        textLabel!.textColor = UIColor.blackColor()
        textLabel?.userInteractionEnabled = false
        addSubview(textLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(frame: CGRect, placeholderImage: UIImage) {
        self.init(frame: frame)
        self.placeholderImage = placeholderImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.frame = CGRectMake(5, 5, width - 15, height - 30)
        textLabel?.frame = CGRectMake(5, height - 25, imageView!.width, 20)
    }
}
