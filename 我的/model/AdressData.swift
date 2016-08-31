//
//  AdressData.swift
//  爱鲜蜂仿2次
//
//  Created by lotawei on 16/8/18.
//  Copyright © 2016年 lotawei. All rights reserved.
//



class AdressData: NSObject, DictModelProtocol {
    
    var code: Int = -1
    var msg: String?
    var data: [Adress]?
    
    static func customClassMapping() -> [String : String]? {
        return ["data" : "\(Adress.self)"]
    }
    
    class func loadMyAdressData(completion:(data: AdressData?, error: NSError?) -> Void) {
        let path = NSBundle.mainBundle().pathForResource("MyAdress", ofType: nil)
        let realdata = NSData(contentsOfFile: path!)
        if realdata != nil {
            //将二进制流文件 data类型转化为字典类型
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(realdata!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let adata = modelTool.objectWithDictionary(dict, cls: AdressData.self) as? AdressData
            completion(data: adata, error: nil)
        }
    }
}


class Adress: NSObject {
    
    var accept_name: String?
    var telphone: String?
    var province_name: String?
    var city_name: String?
    var address: String?
    var lng: String?
    var lat: String?
    var gender: String?
}

