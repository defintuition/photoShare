//
//  UITextField+Extensions.swift
//  programmaticLayout
//
//  Created by Amber Spadafora on 2/6/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

extension UITextField {
    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(0.5)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0.0, y: self.frame.size.height - borderWidth, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func useYellowPlaceHolderText(placeholderText: String = ""){
        let attributesDictionary = [NSForegroundColorAttributeName: UIColor(red:1.00, green:0.84, blue:0.25, alpha:1.0)]
        self.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributesDictionary)
    }
    
    func addTextFieldFormatting(placeholder: String){
        self.useYellowPlaceHolderText(placeholderText: placeholder)
        self.useUnderline()
    }
    
    
}
