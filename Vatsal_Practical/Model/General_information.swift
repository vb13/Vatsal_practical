/* 
Copyright (c) 2023 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct General_information : Mappable {
	var date_of_birth : String?
	var date_of_birth_v1 : String?
	var location : Location?
	var drinking_v1 : Drinking_v1?
	var first_name : String?
	var gender : String?
	var marital_status_v1 : Marital_status_v1?
	var ref_id : String?
	var smoking_v1 : Smoking_v1?
	var sun_sign_v1 : Sun_sign_v1?
	var mother_tongue : Mother_tongue?
	var faith : Faith?
	var height : Int?
	var cast : String?
	var kid : String?
	var diet : String?
	var politics : String?
	var pet : String?
	var settle : String?
	var mbti : String?
	var age : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		date_of_birth <- map["date_of_birth"]
		date_of_birth_v1 <- map["date_of_birth_v1"]
		location <- map["location"]
		drinking_v1 <- map["drinking_v1"]
		first_name <- map["first_name"]
		gender <- map["gender"]
		marital_status_v1 <- map["marital_status_v1"]
		ref_id <- map["ref_id"]
		smoking_v1 <- map["smoking_v1"]
		sun_sign_v1 <- map["sun_sign_v1"]
		mother_tongue <- map["mother_tongue"]
		faith <- map["faith"]
		height <- map["height"]
		cast <- map["cast"]
		kid <- map["kid"]
		diet <- map["diet"]
		politics <- map["politics"]
		pet <- map["pet"]
		settle <- map["settle"]
		mbti <- map["mbti"]
		age <- map["age"]
	}

}