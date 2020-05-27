//
//  PayViewController.swift
//  Pay
//
//  Created by SBI Admin on 2020/05/27.
//  Copyright © 2020 SBI. All rights reserved.
//


import UIKit
import PopupDialog
import CreditCardValidator
import CardScan
import Alamofire

protocol PayControllerDelegate:class {
    func PayDidCancel(_ PayWithPeachController:PayController)
    func pay(_ PayWithPeachController:PayController, didSucceedPaymentWithResult result:[String:AnyObject])
    func pay(_ PayWithPeachController:PayController, didFailPaymentWithResult result:[String:AnyObject])
}

public enum PaymentMethods: String {
    case card = "CARD"
}

public enum PaymentRoute: String {
    case card = "card"
}

class PayController: UIViewController, ScanDelegate,ScanEvents, FullScanStringsDataSource
/*, UIPickerViewDelegate, ValidationDelegate,UIPickerViewDataSource,UITextFieldDelegate */ {
    
    var c_num: String = ""
    var c_month: String = ""
    var c_year: String = ""
    var c_expiry: String = ""
    
    
    let lView2 = UIView()
    let gif2 = UIImageView()
    
    @objc public weak var stringDataSource: ScanStringsDataSource?
    
    @IBOutlet weak var cardNumber: UITextField!
    @IBOutlet weak var expiryDate: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var payNow: UIButton!
    
    weak var delegate:PayControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Make use of Shared Instance Created so, You need not to Re-allocate a New instance just to make use of Delegate
        //PayWithPeachController.shared.delegate = self
        //PayWithPeachControllerDelegate.self
        lView2.backgroundColor = UIColor(white: 1.0, alpha: 0.8)
        gif2.loadGif(name: "Eclipse-1s-200px")
        
        view.addSubview(lView2)
        
        
        view.addSubview(gif2)
        gif2.translatesAutoresizingMaskIntoConstraints = false
        gif2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        gif2.heightAnchor.constraint(equalToConstant: 150).isActive = true
        gif2.centerXAnchor.constraint(lessThanOrEqualTo: self.view.centerXAnchor).isActive = true
        gif2.centerYAnchor.constraint(lessThanOrEqualTo: self.view.centerYAnchor, constant: -60).isActive = true
        
        lView2.translatesAutoresizingMaskIntoConstraints = false
        
        lView2.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        lView2.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        lView2.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        lView2.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        loadingV(is_loading: false)
        cardNumber.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        expiryDate.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        cvv.addTarget(nil, action:Selector(("firstResponderAction:")), for:.editingDidEndOnExit)
        
    }
    
    func userDidCancel(_ scanViewController: ScanViewController) {
        
    }
    
    func userDidScanCard(_ scanViewController: ScanViewController, creditCard: CreditCard) {
        let number = creditCard.number
        let expiryMonth = creditCard.expiryMonth
        let expiryYear = creditCard.expiryYear
        
        
        //print("\(String(describing: expiryMonth))")
        //print("\(String(describing: expiryYear))")
        
        var ex_m: String = ""
        var ar = Array("")
        
        print("\(String(describing: expiryMonth)) / \(String(describing: expiryYear))")
        
        if(expiryMonth == nil){
            
        }
        else{
            if (Int(expiryMonth!)! < 10){
                ex_m = "0\(Int(expiryMonth!)!)"
                
            }else {
                ex_m = "\(Int(expiryMonth!)!)"
            }
            
            let year:Int = Int(expiryYear!)!
            
            let year2: String = "\(year)"
            ar = Array(year2)
            print(ar[2])
            
            
            expiryDate.text = "\(ex_m)/\(ar[2])\(ar[3])"
            
            c_month = "\(ex_m)"
            c_year = "20\(ar[2])\(ar[3])"
            c_expiry = "\(ex_m)/\(ar[2])\(ar[3])"
        }
        
        
        cardNumber.text = number
        
        
        
        /*
        c_month = "\(ex_m)/"
        c_year = "\(ar[2])\(ar[3])"
        c_expiry = "\(ex_m)/\(ar[2])\(ar[3])"
        c_num = number */

        // At this point you have the credit card number and optionally the expiry.
        // You can either tokenize the number or prompt the user for more
        // information (e.g., CVV) before tokenizing.

        self.dismiss(animated: true)
    }
    
    
    func userDidSkip(_ scanViewController: ScanViewController) {
        
    }
    
    
    func onNumberRecognized(number: String, expiry: Expiry?, numberBoundingBox: CGRect, expiryBoundingBox: CGRect?, croppedCardSize: CGSize, squareCardImage: CGImage, fullCardImage: CGImage) {
        //
    }
    
    func onScanComplete(scanStats: ScanStats) {
        //
    }
    
    func onFrameDetected(croppedCardSize: CGSize, squareCardImage: CGImage, fullCardImage: CGImage) {
        //
    }
    
    func denyPermissionTitle() -> String {
        return "New Deny"
    }
    
    func denyPermissionMessage() -> String {
        return "New Deny Message"
    }
    
    func denyPermissionButton() -> String {
        return "GO"
    }
    
    /*
    func nextSquareAndFullImage() -> (CGImage, CGImage)? {
        //
    } */
    
    func scanCard() -> String {
        return "New Scan Card"
    }
    
    func positionCard() -> String {
        return "New Position Card"
    }
    
    func backButton() -> String {
        return "New Back"
    }
    
    func skipButton() -> String {
        return "New Back"
    }
    
    
    
    
    
    //var manager:RavePayManager!
    
    
    /*
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
    }
    
    
    func validationSuccessful() {
        
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        
    } */
    
    
    
    
    
    @IBAction func payNow(_ sender: Any) {
        
        
        /* validate expiery date */
        guard cardNumber.text != "" else {
            
            cardNumber.backgroundColor = .red
            return
        }
        
        
        let check_card = Array(cardNumber.text!)
        var card_type : String?
        
        print("num \(check_card.count)")
        
        //let card_digits = cardNumber.text
        if (check_card[0] == "4"){
            card_type = "VISA"
            
            guard check_card.count == 16 else{
                cardNumber.backgroundColor = .red
                
                return
            }
            
        } else {
            card_type = "MASTER"
            
            guard check_card.count == 16 else{
                cardNumber.backgroundColor = .red
                
                return
            }
        }
        
        /* validate expiery date */
        guard expiryDate.text != "" else {
            
            expiryDate.backgroundColor = .red
            return
        }
        
        if c_year == "" && c_month == "" {
            let ex_ar = Array(expiryDate.text!)
            
            c_month = "\(ex_ar[0])\(ex_ar[1])"
            c_year = "20\(ex_ar[3])\(ex_ar[4])"
            
        }
        
        /* validate ccv date */
        guard cvv.text != "" else {
            
            cvv.backgroundColor = .red
            return
        }
        //let ar_cvv = Array(cvv.text!)
        guard Array(cvv.text!).count == 3 else {
            
            cvv.backgroundColor = .red
            return
        }
        
        
        
        
        let reqbody = [
            "card_number"       : cardNumber.text!,
            "expiry_date"       : c_expiry, // Encrypted $data payload here.
            "cvv"               : "\(String(describing: cvv.text!))",
            "amount"            : "105",
            "brand_type"        : card_type!,
            "c_month"           : c_month,
            "c_year"            : c_year,
            "public_key"        : "pub_b77bdbc5b088ca1e194ba0102a99ebdb",
        ]
        loadingV(is_loading: true)
        print(reqbody)
        self.charge(reqbody: reqbody)
        
        
    }
    @IBAction func goToScan(_ sender: Any) {
        guard let vc = ScanViewController.createViewController(withDelegate: self) else {
            print("This device is incompatible with CardScan")
            return
        }
        vc.allowSkip = true
        vc.stringDataSource = self
        
        vc.backButtonColor = UIColor.red
        vc.hideBackButtonImage = true
        vc.backButtonImageToTextDelta = 8.0
        
        vc.backButtonFont = UIFont(name: "Verdana", size: CGFloat(17.0))
        vc.scanCardFont = UIFont(name: "Chalkduster", size: CGFloat(24.0))
        vc.positionCardFont = UIFont(name: "Chalkduster", size: CGFloat(17.0))
        vc.skipButtonFont = UIFont(name: "Chalkduster", size: CGFloat(17.0))
        
        vc.cornerColor = UIColor.blue
        //vc.torchButtonImage = ScanViewController.cameraImage()

        vc.torchButtonSize = CGSize(width: 44, height: 44)

            self.present(vc, animated: true)
    }
    
    
    func charge(reqbody:[String:String]){
        
        PayService.charge(reqbody, resultCallback: {
            (res) in
            
            if let status = res?["result"] as? Dictionary<String,AnyObject>{
                switch status["code"] as! String {
                    
                case "000.100.110":
                    
                    print("things went right")
                    let callbackResult = res?["description"]
                    
                    showMessageDialog("Success", message: "result:\(status)", image: nil, axis: .horizontal, viewController: self, handler: {
                        self.loadingV(is_loading: false)
                        
                    })
                    /*
                    KVNProgress.showSuccess(completion: {
                        self.delegate?.peachPay(self, didSucceedPaymentWithResult: callbackResult as! [String : AnyObject])
                        print("Do after success")
                        self.navigationController?.dismiss(animated: true, completion: nil)
                        
                    }) */
                    
                    break
                default:
                    break
                }
                
                /*
                print("status: \(status)")
                print(status["code"]!)
                
                guard status["code"]! as! String == "000.100.110" else{
                    print("something went wrong")
                    return
                }
                
                print("things went right") */
                
            }
            
            
        }, errorCallback: { (err) in
            //KVNProgress.dismiss()
            if (err.containsIgnoringCase(find: "serialize") || err.containsIgnoringCase(find: "JSON")){
                DispatchQueue.main.async {
                    self.loadingV(is_loading: false)
                    self.delegate?.pay(self, didFailPaymentWithResult: ["error" : err as AnyObject])
                }
            }else{
                showMessageDialog("Error", message: err, image: nil, axis: .horizontal, viewController: self, handler: {
                    self.loadingV(is_loading: false)
                    
                })
            }
            print(err)
        })
        
    }
    
    func loadingV(is_loading:Bool){
        
        if is_loading == true {
            
            self.lView2.fadeIn()
            lView2.isHidden = false
            
            self.gif2.fadeIn()
            gif2.isHidden = false
            
        } else {
            
            self.lView2.fadeOut()
            lView2.isHidden = true
            
            self.gif2.fadeOut()
            gif2.isHidden = true
        }
        
    }
    
}

extension UIView {

    func fadeIn(_ duration: TimeInterval? = 0.2, onCompletion: (() -> Void)? = nil) {
        self.alpha = 0
        self.isHidden = false
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 1 },
                       completion: { (value: Bool) in
                          if let complete = onCompletion { complete() }
                       }
        )
    }

    func fadeOut(_ duration: TimeInterval? = 5, onCompletion: (() -> Void)? = nil) {
        UIView.animate(withDuration: duration!,
                       animations: { self.alpha = 0 },
                       completion: { (value: Bool) in
                           self.isHidden = true
                           if let complete = onCompletion { complete() }
                       }
        )
    }

}


