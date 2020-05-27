//
//  PayConfig.swift
//  Pay
//
//  Created by SBI Admin on 2020/05/27.
//  Copyright © 2020 SBI. All rights reserved.
//

import UIKit
public class PayConfig: NSObject {
    
    public var publicKey:String?
    public var secretKey:String?
    
    
    public var entityId:String?
    public var accessToken:String?
    public var isStaging:Bool = true
    
    public class func sharedConfig() -> PayConfig {
        
        struct Static {
            static let kbManager = PayConfig()
        }
        
        return Static.kbManager
    }
    
    
}
