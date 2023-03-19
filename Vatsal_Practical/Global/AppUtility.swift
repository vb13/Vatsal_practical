//
//  AppUtility.swift
//  Vatsal_Practical
//
//  Created by VATSAL on 3/19/23.
//

import Foundation
import UIKit


class Common{
    
    let appUtily =  Common()
    
    // MARK: Validation
   class func validateNumber(value: String) -> Bool {
       return value.count > 5 && value.count < 12 ? true : false
    }
    class func validateOTP(value: String) -> Bool {
        return value.count != 4 ? false : true
     }
    
}

extension UIViewController{
    
    func showError(strTitle : String,msg : String){
        let alert = UIAlertController(title: strTitle, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
       func newRoundCorners(corners: UIRectCorner, radius: CGFloat) {
            if #available(iOS 11.0, *) {
                let cornerMasks = [
                    corners.contains(.topLeft) ? CACornerMask.layerMinXMinYCorner : nil,
                    corners.contains(.topRight) ? CACornerMask.layerMaxXMinYCorner : nil,
                    corners.contains(.bottomLeft) ? CACornerMask.layerMinXMaxYCorner : nil,
                    corners.contains(.bottomRight) ? CACornerMask.layerMaxXMaxYCorner : nil,
                    corners.contains(.allCorners) ? [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner] : nil
                    ].compactMap({ $0 })

                var maskedCorners: CACornerMask = []
                cornerMasks.forEach { (mask) in maskedCorners.insert(mask) }

                self.clipsToBounds = true
                self.layer.cornerRadius = radius
                self.layer.maskedCorners = maskedCorners
            } else {
                let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
                let mask = CAShapeLayer()
                mask.path = path.cgPath
                self.layer.mask = mask
            }
        }
   
}
