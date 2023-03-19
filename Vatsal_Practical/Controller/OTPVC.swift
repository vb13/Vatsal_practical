//
//  OTPVC.swift
//  Vatsal_Practical
//
//  Created by VATSAL on 3/19/23.
//

import UIKit
import Alamofire
import ProgressHUD
import ObjectMapper

class OTPVC: UIViewController {

    
    //MARK: Outlets
    @IBOutlet weak var lblNumber : UILabel!
    @IBOutlet weak var lblNumberTitle : UILabel!
    @IBOutlet weak var lblTimer : UILabel!
    @IBOutlet weak var txtOTP : UITextField!
    @IBOutlet weak var btnContinue : UIButton!
    
    //MARK: Varibles
    var strNumber =  ""
    var timer = Timer()
    var totalTimer =  11
    
    //MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer.invalidate()
    }
    
    //MARK:  Custom function
    func setUI(){
        self.lblNumber.text = strNumber
        self.lblNumberTitle.text = "Enter The \nOTP"
        btnContinue.layer.cornerRadius =  self.btnContinue.frame.height / 2
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    // must be internal or public.
    @objc func update() {
        
        totalTimer -= 1
            if totalTimer == 0 {
                self.lblTimer.text =  "00:\(totalTimer)"
              timer.invalidate()
            }else{
                if totalTimer > 10 {
                    self.lblTimer.text =  "00:\(totalTimer)"
                }else{
                    self.lblTimer.text =  "00:0\(totalTimer)"
                }
            }
    }
    
    func isValidate() -> Bool{
        if self.txtOTP.text?.isEmpty ==  true{
            showError(strTitle: "Error", msg: Message.enterOTP)
            txtOTP.becomeFirstResponder()
            return  false
        }
        if !Common.validateOTP(value: self.txtOTP.text!){
            showError(strTitle: "Error", msg: Message.validOTP)
            self.txtOTP.becomeFirstResponder()
            return  false
        }
        return true
    }
    
    
    //MARK: Button Action
    @IBAction func btnContinueAction(_ sender : Any){
        if isValidate(){
            callVerifyOTPAPI()
        }
    }
    
    @IBAction func btnEditAction(_ sender : Any){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    //MARK: API CALL
    func callVerifyOTPAPI() {
        ProgressHUD.show()
//        let headers  : HTTPHeaders = ["Content-Type" : "application/json"]
        let parametter =
        ["number":strNumber,"otp":self.txtOTP.text!]
        print("=============")
        print(parametter)
        print("=============")
        AF.request(APIURL.VERIFYOTP, method: .post, parameters: parametter, encoding: URLEncoding.default).responseJSON { response in
          switch response.result {
          case .success (let data):
            let dictResponse = data as? [String:Any]
              if let token = dictResponse?["token"] as? String{
                  print("TOKEN :- \(token)")
                  UserDefaults.standard.setValue(token, forKey: "token")
                  UserDefaults.standard.synchronize()
                  let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesVC") as! NotesVC
                  self.navigationController?.pushViewController(vc, animated: true)
                  
              }
              ProgressHUD.dismiss()
          case let .failure(error):
            print(error)
              ProgressHUD.dismiss()
          }
        }
        
        
    }
}
