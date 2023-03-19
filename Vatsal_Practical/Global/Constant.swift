//
//  Constant.swift
//  Vatsal_Practical
//
//  Created by VATSAL on 3/19/23.
//

import Foundation


let BASEURL = "https://app.aisle.co/V1/"


struct APIURL {
    
    static let LOGIN = BASEURL + "users/phone_number_login"
    static let VERIFYOTP = BASEURL + "users/verify_otp"
    static let NOTELIST = BASEURL + "users/test_profile_list"
}


struct Message {
    
    static let emptyCountryCode = "Please enter country code"
    static let emptyPhonenumber = "Please enter phone number"
    static let validphoneNumber = "Please enter valid phone number"
    static let enterOTP = "Please enter OTP"
    static let validOTP = "Please enter valid OTP"
    
    
    
}

