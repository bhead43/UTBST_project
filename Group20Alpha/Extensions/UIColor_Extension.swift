//
//  UIColor_Extension.swift
//  Group20Alpha
//
//  Created by Adam Luna on 4/3/18.
//  Copyright © 2018 Group 20. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}

public extension UIColor {
    
    static var greenBorderColor: UIColor = {
        return UIColor(r: 80, g: 227, b: 194)
    }()
    
    static var redBorderColor: UIColor = {
        return UIColor(r: 255, g: 151, b: 164)
    }()
    
    static var blackBorderColor: UIColor = {
        return UIColor(r: 0, g: 0, b: 0)
    }()
    
    
}
