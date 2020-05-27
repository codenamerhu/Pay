//
//  Constants.swift
//  Pay
//
//  Created by SBI Admin on 2020/05/27.
//  Copyright © 2020 SBI. All rights reserved.
//

import UIKit
import Alamofire

public class Constants: NSObject {
    
    class func sandboxBaseURL() -> String { return "https://paywithpeachsdk.herokuapp.com" }
    
    class func liveBaseURL () -> String { return "" }
    
    class func isConnectedToInternet() ->Bool { return NetworkReachabilityManager()!.isReachable }
    
    class func relativeURL()->Dictionary<String,String>{
        return [
            /*
            "CHARGE_CARD" :"/flwv3-pug/getpaidx/api/charge",
            "VALIDATE_CARD_OTP" :"/flwv3-pug/getpaidx/api/validatecharge",
            "VALIDATE_ACCOUNT_OTP":"/flwv3-pug/getpaidx/api/validate",
            "BANK_LIST":"/flwv3-pug/getpaidx/api/flwpbf-banks.js?json=1",
            "CHARGE_WITH_TOKEN":"/flwv3-pug/getpaidx/api/tokenized/charge",
            "QUERY_TRANSACTION":"/flwv3-pug/getpaidx/api/verify",
            "QUERY_TRANSACTION_V2":"/flwv3-pug/getpaidx/api/v2/verify",
            "SAVED_CARDS_LOOKUP":"/v2/gpx/users/lookup",
            "FEE":"/flwv3-pug/getpaidx/api/fee" */
            
            "PAY": "/api/payment/pay"
            
            
        ]
    }
    
}
