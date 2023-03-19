//
//  ViewController.swift
//  Vatsal_Practical
//
//  Created by VATSAL on 3/18/23.
//

import UIKit
import Alamofire
import ProgressHUD
import ObjectMapper

class ViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var lblNumberTitle : UILabel!
    @IBOutlet weak var txtCountrycode : UITextField!
    @IBOutlet weak var txtNumber : UITextField!
    @IBOutlet weak var btnContinue : UIButton!
    
    //MARK: Varibles
    
    //MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    //MARK:  Custom function
    func setUI(){
        self.lblNumberTitle.text = "Enter Your \nPhone Number"
        btnContinue.layer.cornerRadius =  self.btnContinue.frame.height / 2
        txtCountrycode.delegate = self
        
    }
    
    func isValidate() -> Bool{
        if self.txtCountrycode.text?.isEmpty ==  true{
            showError(strTitle: "Error", msg: Message.emptyCountryCode)
            txtCountrycode.becomeFirstResponder()
            return  false
        }
        if self.txtNumber.text?.isEmpty ==  true{
            showError(strTitle: "Error", msg: Message.emptyPhonenumber)
            self.txtNumber.becomeFirstResponder()
            return  false
        }
        if !Common.validateNumber(value: self.txtNumber.text!){
            showError(strTitle: "Error", msg: Message.validphoneNumber)
            self.txtNumber.becomeFirstResponder()
            return  false
        }
        return true
    }
    
    
    //MARK: Button Action
    @IBAction func btnContinueAction(_ sender : Any){
        if isValidate(){
            print("validation sccuess")
            //919876543212
            callLoginAPI()
        }
    }
    
    
    //MARK: API CALL
    func callLoginAPI() {
        ProgressHUD.show()
//        let headers  : HTTPHeaders = ["Content-Type" : "application/json"]
        let parametter =
        ["number":"\(txtCountrycode.text!)\(self.txtNumber.text!)"]
        print("=============")
        print(parametter)
        print("=============")
        AF.request(APIURL.LOGIN, method: .post, parameters: parametter, encoding: URLEncoding.default).responseJSON { response in
          switch response.result {
          case .success (let data):
              ProgressHUD.dismiss()
            let dictResponse = data as? [String:Any]
              if let status = dictResponse?["status"] as? Bool{
                  if status{
                      let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OTPVC") as! OTPVC
                      vc.strNumber =  "\(self.txtCountrycode.text!)\(self.txtNumber.text!)"
                      self.navigationController?.pushViewController(vc, animated: true)
                  }
              }
              
          case let .failure(error):
            print(error)
              ProgressHUD.dismiss()
          }
        }
        
        
    }
}
//MARK:  TextField Delegate Method
extension ViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 4
        let currentString = (textField.text ?? "") as NSString
        let newString = currentString.replacingCharacters(in: range, with: string)

        return newString.count <= maxLength
    }
}

