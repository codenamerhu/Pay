//
//  Extensions.swift
//  Pay
//
//  Created by SBI Admin on 2020/05/27.
//  Copyright © 2020 SBI. All rights reserved.
//
import UIKit
import PopupDialog
import CommonCrypto

func showMessageDialog (_ title:String, message:String , image:UIImage?,
    //axis:UILayoutConstraintAxis,viewController:UIViewController, handler:(() -> Void)?){
    axis:NSLayoutConstraint.Axis,viewController:UIViewController, handler:(() -> Void)?){
   //let popUp = PopupDialog(title: title, message: message, image: image, buttonAlignment: axis, transitionStyle: PopupDialogTransitionStyle.zoomIn, gestureDismissal: true, completion: handler)
    let popUp = PopupDialog(title: title, message: message, image:image, buttonAlignment: axis, transitionStyle: PopupDialogTransitionStyle.zoomIn, completion: handler)
    
    if let  _ = handler{
        let button =  DefaultButton(title: "OK"){
            handler!()
        }
        popUp.addButtons([button])
    }
    
    
    _ = viewController.present(popUp, animated: true)
}

extension String{
    func toCurrency(_ withFraction:Int = 0, locale:String = "ig_NG") -> String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = withFraction
        formatter.locale = Locale(identifier: locale)
        if self == ""{
            return formatter.string(from: NSNumber(value: 0))!
        }else{
            let val = (self as NSString).doubleValue
            return formatter.string(from: NSNumber(value: val))!
        }
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    func index(of target: String) -> Int? {
        if let range = self.range(of: target) {
            return distance(from: startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    
    func lastIndex(of target: String) -> Int? {
        if let range = self.range(of: target, options: .backwards) {
            return distance(from: startIndex, to: range.lowerBound)
        } else {
            return nil
        }
    }
    func toCountryCurrency(code:String) -> String{
        var str:String = ""
        switch code {
        case "NGN":
            str = self.toCurrency(2)
        case "USD":
            str = self.toCurrency(2,locale:"en_US")
        case "GBP":
            str = self.toCurrency(2,locale:"en_GB")
        case "KES":
            str = self.toCurrency(2,locale:"kam_KE")
        case "GHS":
            str = self.toCurrency(2,locale:"ak_GH")
        case "ZAR":
            str = self.toCurrency(2, locale: "en_ZA")
        case "EUR":
            str = self.toCurrency(2, locale: "de_DE")
        case "UGX":
            str = self.toCurrency(2, locale: "nyn_UG")
        default:
            str = self.toCurrency(2)
            
        }
        return str
    }
    
}

