//
//  UILable_Extenstion.swift
//  Group20Alpha
//
//  Created by Brandon Head on 4/21/18.
//  Copyright © 2018 Group 20. All rights reserved.
//
import Foundation
import UIKit

// extension Class
extension UILabel {
    
    // extension user defined Method
    public convenience init(placeHolder: String, borderColor: UIColor, title: String) {
        self.init()
        self.backgroundColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 0.2)
        self.font = UIFont.systemFont(ofSize: 17)
        // placeholder (taken from UITextField Extension)
        var placeholder = NSMutableAttributedString()
        placeholder = NSMutableAttributedString(attributedString: NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor(white: 1, alpha: 0.7)]))
        self.setAnchor(width: 50, height: 50)
    }
    
    func setRoundEdge() {
        let myGreenColor = (UIColor(red: -0.108958, green: 0.714926, blue: 0.758113, alpha: 1.0))
        //Width of border
        self.layer.borderWidth = 1.0
        //How much the edge to be rounded [8 for a circle]
        self.layer.cornerRadius = 8.0
        // following properties are optional
        //color for border
        self.layer.borderColor = myGreenColor.cgColor
        //color for text
        self.textColor = UIColor.red
        // Mask the bound
        self.layer.masksToBounds = true
        //clip the pixel contents
        self.clipsToBounds = true
        
    }
}
