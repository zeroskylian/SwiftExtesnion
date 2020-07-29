//
//  UIColor+Hex.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2018/7/2.
//  Copyright © 2018年 廉鑫博. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    
    /// Int 创建 color
    ///
    /// - Parameters:
    ///   - red: r
    ///   - green: g
    ///   - blue: b
    ///   - a: alpha
    convenience init(red:Int,green: Int,blue:Int,a:CGFloat = 1.0){
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha:a)
    }
    
    
    /// 16 进制创建color
    ///
    /// - Parameters:
    ///   - hex: 0x000000
    ///   - a: alpha
    convenience init(hex: Int, a: CGFloat = 1.0) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF,
            a: a
        )
    }
    
    
    var cgColorComponents:[CGFloat]?
    {
        return self.cgColor.components
    }
    
    var r:CGFloat?{
        if self.cgColorComponents?.count == 4
        {
            return self.cgColorComponents?.first
        }else
        {
            return nil
        }
        
    }
    
    
    var g:CGFloat?{
        if self.cgColorComponents?.count == 4
        {
            return self.cgColorComponents?[1]
        }else
        {
            return nil
        }
    }
    
    var b:CGFloat?{
        if self.cgColorComponents?.count == 4
        {
            return self.cgColorComponents?[2]
        }else
        {
            return nil
        }
    }
    
    var alpha:CGFloat?{
        
        if self.cgColorComponents?.count == 4
        {
            return self.cgColorComponents?.last
        }else
        {
            return nil
        }
    }
}
