//
//  PayNetworkSerive.swift
//  Pay
//
//  Created by SBI Admin on 2020/05/27.
//  Copyright © 2020 SBI. All rights reserved.
//


import Alamofire

class PayService: NSObject {
    
    class func charge(_ bodyParam:Dictionary<String,Any>,resultCallback:@escaping (_ Result:Dictionary<String,AnyObject>?) -> Void ,errorCallback:@escaping (_ err:String) -> Void ){
        
        let manager = AF
               manager.session.configuration.timeoutIntervalForRequest = 30
               manager.session.configuration.timeoutIntervalForResource = 30
               manager.request(URLHelper.getURL("PAY"),method: .post, parameters: bodyParam).responseJSON {
                   //(res) -> Void in
                   
                /*
                   if(res.result.isSuccess){
                       let result = res.result.value as! Dictionary<String,AnyObject>
                        print(result)
                       resultCallback(result)
                       
                       
                   }else{
                       errorCallback( res.result.error!.localizedDescription)
                   } */
                res in switch res.result {
                    
                case .success(_):
                    //print(res)
                    let valid = "\(res.result)"
                    
                    let ar = Array(valid)
                    //print(ar)
                    
                    if (ar[8] == "4"){
                        print("something went wrong")
                        //errorCallback( res.error!.localizedDescription)
                        
                    }else {
                    let result = res.value as! Dictionary<String,AnyObject>
                    print("result: ")
                    print(result)
                    
                       // let data = result["data"] as? Dictionary<String,AnyObject>
                        resultCallback(result)
                    }
                    
                case .failure(let errorOut):
                    print(errorOut)
                    errorCallback( res.error!.localizedDescription)
                }
               }
        
    }
    
}
