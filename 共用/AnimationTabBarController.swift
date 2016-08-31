//
//  AnimationTabBarController.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/13.
//  Copyright © 2016年 lotawei. All rights reserved.
//



//关于   此类的 动画 可以官方网站上学习  tar-bar-animation


/// 方式五 ：
class RAMFrameItemAnimation: RAMItemAnimation {
    
    @nonobjc private var animationImages : Array<CGImage> = Array()
    
    var selectedImage : UIImage!
    
    /// A Boolean value indicated plaing revers animation when UITabBarItem unselected, if false image change immediately, defalut value true
    @IBInspectable  var isDeselectAnimation: Bool = true
    
    /// path to array of image names from plist file
    @IBInspectable  var imagesPath: String!
    
    override  func awakeFromNib() {
        
        guard let path = NSBundle.mainBundle().pathForResource(imagesPath, ofType:"plist") else {
            fatalError("don't found plist")
        }
        
        guard case let animationImagesName as [String] = NSArray(contentsOfFile: path) else {
            fatalError()
        }
        
        createImagesArray(animationImagesName)
        
        // selected image
        let selectedImageName = animationImagesName[animationImagesName.endIndex - 1]
        selectedImage = UIImage(named: selectedImageName)
    }
    
    func createImagesArray(imageNames : Array<String>) {
        for name : String in imageNames {
            if let image = UIImage(named: name)?.CGImage {
                animationImages.append(image)
            }
        }
    }
    
    // MARK: public
    
    /**
     Set images for keyframe animation
     
     - parameter images: images for keyframe animation
     */
    func setAnimationImages(images: Array<UIImage>) {
        var animationImages = Array<CGImage>()
        for image in images {
            if let cgImage = image.CGImage {
                animationImages.append(cgImage)
            }
        }
        self.animationImages = animationImages
    }
    
    // MARK: RAMItemAnimationProtocol
    
    /**
     Start animation, method call when UITabBarItem is selected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func playAnimation(icon : UIImageView, textLabel : UILabel) {
        
        playFrameAnimation(icon, images:animationImages)
        textLabel.textColor = textSelectedColor
    }
    
    /**
     Start animation, method call when UITabBarItem is unselected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     - parameter defaultTextColor: default UITabBarItem text color
     - parameter defaultIconColor: default UITabBarItem icon color
     */
    override  func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor, defaultIconColor : UIColor) {
        if isDeselectAnimation {
            playFrameAnimation(icon, images:animationImages.reverse())
        }
        
        textLabel.textColor = defaultTextColor
    }
    
    /**
     Method call when TabBarController did load
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func selectedState(icon : UIImageView, textLabel : UILabel) {
        icon.image = selectedImage
        textLabel.textColor = textSelectedColor
    }
    
    @nonobjc func playFrameAnimation(icon : UIImageView, images : Array<CGImage>) {
        let frameAnimation = CAKeyframeAnimation(keyPath: Constants.AnimationKeys.KeyFrame)
        frameAnimation.calculationMode = kCAAnimationDiscrete
        frameAnimation.duration = NSTimeInterval(duration)
        frameAnimation.values = images
        frameAnimation.repeatCount = 1
        frameAnimation.removedOnCompletion = false
        frameAnimation.fillMode = kCAFillModeForwards
        icon.layer.addAnimation(frameAnimation, forKey: nil)
    }
}


/// 方式四 ： 旋转
import QuartzCore

/// The RAMRotationAnimation class provides rotation animation.
class RAMRotationAnimation : RAMItemAnimation {
    
    /**
     Animation direction
     
     - Left:  left direction
     - Right: right direction
     */
    enum RAMRotationDirection {
        case Left
        case Right
    }
    /// Animation direction (left, right)
    var direction : RAMRotationDirection!
    
    /**
     Start animation, method call when UITabBarItem is selected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func playAnimation(icon : UIImageView, textLabel : UILabel) {
        playRoatationAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    /**
     Start animation, method call when UITabBarItem is unselected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     - parameter defaultTextColor: default UITabBarItem text color
     - parameter defaultIconColor: default UITabBarItem icon color
     */
    override  func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor, defaultIconColor : UIColor) {
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            let renderMode = CGColorGetAlpha(defaultIconColor.CGColor) == 0 ? UIImageRenderingMode.AlwaysOriginal :
                UIImageRenderingMode.AlwaysTemplate
            let renderImage = iconImage.imageWithRenderingMode(renderMode)
            icon.image = renderImage
            icon.tintColor = defaultIconColor
        }
    }
    
    /**
     Method call when TabBarController did load
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func selectedState(icon : UIImageView, textLabel : UILabel) {
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    func playRoatationAnimation(icon : UIImageView) {
        
        let rotateAnimation = CABasicAnimation(keyPath: Constants.AnimationKeys.Rotation)
        rotateAnimation.fromValue = 0.0
        
        var toValue = CGFloat(M_PI * 2.0)
        if direction != nil && direction == RAMRotationDirection.Left {
            toValue = toValue * -1.0
        }
        
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = NSTimeInterval(duration)
        
        icon.layer.addAnimation(rotateAnimation, forKey: nil)
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
}

/// The RAMLeftRotationAnimation class provides letf rotation animation.
class RAMLeftRotationAnimation : RAMRotationAnimation {
    
    override init() {
        super.init()
        direction = RAMRotationDirection.Left
    }
}

/// The RAMRightRotationAnimation class provides rigth rotation animation.
class RAMRightRotationAnimation : RAMRotationAnimation {
    
    override init() {
        super.init()
        direction = RAMRotationDirection.Right
    }
}



/// 方式三：
class RAMTransitionItemAnimations : RAMItemAnimation {
    
    ///  Options for animating. Default TransitionNone
    var transitionOptions : UIViewAnimationOptions!
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionNone
    }
    
    /**
     Start animation, method call when UITabBarItem is selected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func playAnimation(icon : UIImageView, textLabel : UILabel) {
        
        selectedColor(icon, textLabel: textLabel)
        
        UIView.transitionWithView(icon, duration: NSTimeInterval(duration), options: transitionOptions, animations: {
            }, completion: { _ in
        })
    }
    
    /**
     Start animation, method call when UITabBarItem is unselected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     - parameter defaultTextColor: default UITabBarItem text color
     - parameter defaultIconColor: default UITabBarItem icon color
     */
    override  func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor, defaultIconColor : UIColor) {
        
        if let iconImage = icon.image {
            let renderMode = CGColorGetAlpha(defaultIconColor.CGColor) == 0 ? UIImageRenderingMode.AlwaysOriginal :
                UIImageRenderingMode.AlwaysTemplate
            let renderImage = iconImage.imageWithRenderingMode(renderMode)
            icon.image = renderImage
            icon.tintColor = defaultIconColor
        }
        textLabel.textColor = defaultTextColor
    }
    
    /**
     Method call when TabBarController did load
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func selectedState(icon : UIImageView, textLabel : UILabel) {
        
        selectedColor(icon, textLabel: textLabel)
    }
    
    
    func selectedColor(icon : UIImageView, textLabel : UILabel) {
        
        if let iconImage = icon.image where iconSelectedColor != nil {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
        
        textLabel.textColor = textSelectedColor
    }
}

class RAMFlipLeftTransitionItemAnimations : RAMTransitionItemAnimations {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
    }
}


class RAMFlipRightTransitionItemAnimations : RAMTransitionItemAnimations {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
    }
}

class RAMFlipTopTransitionItemAnimations : RAMTransitionItemAnimations {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromTop
    }
}

class RAMFlipBottomTransitionItemAnimations : RAMTransitionItemAnimations {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromBottom
    }
}



/// 方式二：
class RAMFumeAnimation : RAMItemAnimation {
    
    /**
     Start animation, method call when UITabBarItem is selected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func playAnimation(icon : UIImageView, textLabel : UILabel) {
        playMoveIconAnimation(icon, values:[icon.center.y, icon.center.y + 4.0])
        playLabelAnimation(textLabel)
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    /**
     Start animation, method call when UITabBarItem is unselected
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     - parameter defaultTextColor: default UITabBarItem text color
     - parameter defaultIconColor: default UITabBarItem icon color
     */
    override  func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor, defaultIconColor : UIColor) {
        
        playMoveIconAnimation(icon, values:[icon.center.y + 4.0, icon.center.y])
        playDeselectLabelAnimation(textLabel)
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            let renderMode = CGColorGetAlpha(defaultIconColor.CGColor) == 0 ? UIImageRenderingMode.AlwaysOriginal :
                UIImageRenderingMode.AlwaysTemplate
            let renderImage = iconImage.imageWithRenderingMode(renderMode)
            icon.image = renderImage
            icon.tintColor = defaultIconColor
        }
    }
    
    /**
     Method call when TabBarController did load
     
     - parameter icon:      animating UITabBarItem icon
     - parameter textLabel: animating UITabBarItem textLabel
     */
    override  func selectedState(icon : UIImageView, textLabel : UILabel) {
        
        playMoveIconAnimation(icon, values:[icon.center.y + 12.0])
        textLabel.alpha = 0
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysTemplate)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    func playMoveIconAnimation(icon : UIImageView, values: [AnyObject]) {
        
        let yPositionAnimation = createAnimation(Constants.AnimationKeys.PositionY, values:values, duration:duration / 2)
        
        icon.layer.addAnimation(yPositionAnimation, forKey: nil)
    }
    
    // MARK: select animation
    
    func playLabelAnimation(textLabel: UILabel) {
        
        let yPositionAnimation = createAnimation(Constants.AnimationKeys.PositionY, values:[textLabel.center.y, textLabel.center.y - 60.0], duration:duration)
        yPositionAnimation.fillMode = kCAFillModeRemoved
        yPositionAnimation.removedOnCompletion = true
        textLabel.layer.addAnimation(yPositionAnimation, forKey: nil)
        
        let scaleAnimation = createAnimation(Constants.AnimationKeys.Scale, values:[1.0 ,2.0], duration:duration)
        scaleAnimation.fillMode = kCAFillModeRemoved
        scaleAnimation.removedOnCompletion = true
        textLabel.layer.addAnimation(scaleAnimation, forKey: nil)
        
        let opacityAnimation = createAnimation(Constants.AnimationKeys.Opacity, values:[1.0 ,0.0], duration:duration)
        textLabel.layer.addAnimation(opacityAnimation, forKey: nil)
    }
    
    func createAnimation(keyPath: String, values: [AnyObject], duration: CGFloat)->CAKeyframeAnimation {
        
        let animation = CAKeyframeAnimation(keyPath: keyPath)
        animation.values = values
        animation.duration = NSTimeInterval(duration)
        animation.calculationMode = kCAAnimationCubic
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        return animation
    }
    
    // MARK: deselect animation
    
    func playDeselectLabelAnimation(textLabel: UILabel) {
        
        let yPositionAnimation = createAnimation(Constants.AnimationKeys.PositionY, values:[textLabel.center.y + 15, textLabel.center.y], duration:duration)
        textLabel.layer.addAnimation(yPositionAnimation, forKey: nil)
        
        let opacityAnimation = createAnimation(Constants.AnimationKeys.Opacity, values:[0, 1], duration:duration)
        textLabel.layer.addAnimation(opacityAnimation, forKey: nil)
    }
}




/// 方式一 ：
class RAMBounceAnimation : RAMItemAnimation {
    
    override func playAnimation(icon : UIImageView, textLabel : UILabel) {
        playBounceAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        textLabel.textColor = defaultTextColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = defaultTextColor
            
        }
    }
    
    override func selectedState(icon : UIImageView, textLabel : UILabel) {
        textLabel.textColor = textSelectedColor
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = textSelectedColor
        }
    }
    
    func playBounceAnimation(icon : UIImageView) {
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = NSTimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
        
        if let iconImage = icon.image {
            let renderImage = iconImage.imageWithRenderingMode(.AlwaysOriginal)
            icon.image = renderImage
            icon.tintColor = iconSelectedColor
        }
    }
    
}


class RAMAnimatedTabBarItem: UITabBarItem {
    
    var animation: RAMItemAnimation?
    
    var textColor = UIColor.grayColor()
    
    func playAnimation(icon: UIImageView, textLabel: UILabel){
        guard let animation = animation else {
            print("add animation in UITabBarItem")
            return
        }
        animation.playAnimation(icon, textLabel: textLabel)
    }
    
    func deselectAnimation(icon: UIImageView, textLabel: UILabel) {
        animation?.deselectAnimation(icon, textLabel: textLabel, defaultTextColor: textColor)
    }
    
    func selectedState(icon: UIImageView, textLabel: UILabel) {
        animation?.selectedState(icon, textLabel: textLabel)
    }
}

protocol RAMItemAnimationProtocol {
    
    func playAnimation(icon : UIImageView, textLabel : UILabel)
    func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor)
    func selectedState(icon : UIImageView, textLabel : UILabel)
}

class RAMItemAnimation: NSObject, RAMItemAnimationProtocol {
    
    
    
    struct Constants {
        
        struct AnimationKeys {
            
            static let Scale     = "transform.scale"
            static let Rotation    = "transform.rotation"
            static let KeyFrame  = "contents"
            static let PositionY = "position.y"
            static let Opacity   = "opacity"
        }
        
    }
    
    var duration : CGFloat = 0.6
    var textSelectedColor: UIColor = UIColor.grayColor()
    var iconSelectedColor: UIColor?
    
    func playAnimation(icon : UIImageView, textLabel : UILabel) {
    }
    
    func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor) {
        
    }
    
    func selectedState(icon: UIImageView, textLabel : UILabel) {
    }
    func deselectAnimation(icon : UIImageView, textLabel : UILabel, defaultTextColor : UIColor, defaultIconColor : UIColor){
        
    }
    
    
}


class AnimationTabBarController: UITabBarController {
    
    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = []
    var iconsImageName:[String] = ["v2_home", "v2_order", "shopCart", "v2_my"]
    var iconsSelectedImageName:[String] = ["v2_home_r", "v2_order_r", "shopCart_r", "v2_my_r"]
    var shopCarIcon: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AnimationTabBarController.searchViewControllerDeinit), name: "LFBSearchViewControllerDeinit", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func searchViewControllerDeinit() {
        if shopCarIcon != nil {
            let redDotView = ShopCarRedDotView.sharedRedDotView
            redDotView.frame = CGRectMake(21 + 1, -3, 15, 15)
            shopCarIcon?.addSubview(redDotView)
        }
    }
    
    func createViewContainers() -> [String: UIView] {
        var containersDict = [String: UIView]()
        
        guard let customItems = tabBar.items as? [RAMAnimatedTabBarItem] else
        {
            return containersDict
        }
        
        for index in 0..<customItems.count {
            let viewContainer = createViewContainer(index)
            containersDict["container\(index)"] = viewContainer
        }
        
        return containersDict
    }
    
    func createViewContainer(index: Int) -> UIView {
        
        let viewWidth: CGFloat = ScreenWidth / CGFloat(tabBar.items!.count)
        let viewHeight: CGFloat = tabBar.bounds.size.height
        
        let viewContainer = UIView(frame: CGRectMake(viewWidth * CGFloat(index), 0, viewWidth, viewHeight))
        
        viewContainer.backgroundColor = UIColor.clearColor()
        viewContainer.userInteractionEnabled = true
        
        tabBar.addSubview(viewContainer)
        viewContainer.tag = index
        
        
        
        return viewContainer
    }
    
    
    
    func createCustomIcons(containers : [String: UIView]) {
        if let items = tabBar.items {
            
            for (index, item) in items.enumerate() {
                
                assert(item.image != nil, "add image icon in UITabBarItem")
                
                guard let container = containers["container\(index)"] else
                {
                    print("No container given")
                    continue
                }
                
                container.tag = index
                
                let imageW:CGFloat = 21
                let imageX:CGFloat = (ScreenWidth / CGFloat(items.count) - imageW) * 0.5
                let imageY:CGFloat = 8
                let imageH:CGFloat = 21
                let icon = UIImageView(frame: CGRect(x: imageX, y: imageY, width: imageW, height: imageH))
                icon.image = item.image
                icon.tintColor = UIColor.clearColor()
                
                
                // text
                let textLabel = UILabel()
                textLabel.frame = CGRectMake(0, 32, ScreenWidth / CGFloat(items.count), 49 - 32)
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.textColor = UIColor.grayColor()
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                container.addSubview(icon)
                container.addSubview(textLabel)
                
                
                if let tabBarItem = tabBar.items {
                    let textLabelWidth = tabBar.frame.size.width / CGFloat(tabBarItem.count)
                    textLabel.bounds.size.width = textLabelWidth
                }
                /**
                 *  由于购物车 和 其他的控制器不一样
                 */
                if 2 == index {
                    let redDotView = ShopCarRedDotView.sharedRedDotView
                    redDotView.frame = CGRectMake(imageH + 1, -3, 15, 15)
                    icon.addSubview(redDotView)
                    shopCarIcon = icon
                }
                
                let iconsAndLabels = (icon:icon, textLabel:textLabel)
                iconsView.append(iconsAndLabels)
                
                
                item.image = nil
                item.title = ""
                
                if index == 0 {
                    selectedIndex = 0
                    selectItem(0)
                }
            }
        }
    }
    
    
    //代理    bar
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        setSelectIndex(from: selectedIndex, to: item.tag)
    }
    
    func selectItem(Index: Int) {
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        let selectIcon = iconsView[Index].icon
        selectIcon.image = UIImage(named: iconsSelectedImageName[Index])!
        items[Index].selectedState(selectIcon, textLabel: iconsView[Index].textLabel)
    }
    
    func setSelectIndex(from from: Int,to: Int) {
        
        if to == 2 {
            let vc = childViewControllers[selectedIndex]
            let shopCar = ShopCartViewController()
            let nav = BaseNavigationController(rootViewController: shopCar)
            vc.presentViewController(nav, animated: true, completion: nil)
            
            return
        }
        
        selectedIndex = to
        let items = tabBar.items as! [RAMAnimatedTabBarItem]
        
        let fromIV = iconsView[from].icon
        fromIV.image = UIImage(named: iconsImageName[from])
        items[from].deselectAnimation(fromIV, textLabel: iconsView[from].textLabel)
        
        let toIV = iconsView[to].icon
        toIV.image = UIImage(named: iconsSelectedImageName[to])
        items[to].playAnimation(toIV, textLabel: iconsView[to].textLabel)
    }
}
