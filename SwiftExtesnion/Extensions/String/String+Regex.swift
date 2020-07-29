//
//  String + Rex.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/3/14.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import Foundation

extension String {
    
    enum Regular:String {
        
        /// chinese
        case chinese = #"[\u4E00-\u9FA5]"#
        
        /// english
        case english = #"[A-Za-z]"#
        
        /// 数字
        case number = #"[0-9]"#
        
        /// 邮箱
        case emailAddress = #"[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        
        /// 手机号
        case mobileNumber = "^[1][3456789][0-9]{9}$"
        
        /// 身份证号
        case idNumber = #"^(\d{14}|\d{17})(\d|[xX])$"#
        
        /// 车牌号 formatter eg:湘K-DE829
        case numberPlate = #"^[\u4e00-\u9fff]{1}[a-zA-Z]{1}[-][a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fff]$"#
    }
    
    /// ^ 说明 [1-9]表示匹配数字 ,"^"用在中括号中表示 反 [^1-9]表示匹配非 1-9的数字
    /*
     let str1 = "aaa.1234490lian"
     //判断表情的正则表达式
     let pattern = "[^0-9]"
     //替换后的字符串
     let str2 = str1.pregReplace(pattern: pattern, with: "_")
     //打印结果
     print("原字符串：\(str1)") aaa.1234490lian
     print("新字符串：\(str2)") ____1234490____
     */
    
    /// 使用正则表达式替换 如果不匹配pattern 则替换 将不是pattern的替换为with
    ///
    /// - Parameters:
    ///   - pattern: 非中文：[^\\u4E00-\\u9FA5]
    ///              非英文：[^A-Za-z]
    ///              非数字：[^0-9]
    ///              非中文或英文：[^A-Za-z\\u4E00-\\u9FA5]
    ///              非英文或数字：[^A-Za-z0-9]
    ///              非英文或数字或下划线：[^A-Za-z0-9_]
    ///
    ///   - with: 替换为的字符串
    ///   - options: options
    /// - Returns: 替换后的
    func pregReplace(pattern: String, with: String,
                     options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange(0, self.count),
                                              withTemplate: with)
    }
    
    
    func isValidateByRegex(regular:String) -> Bool
    {
        return NSPredicate(format: "SELF MATCHES %@", regular).evaluate(with: self)
    }
    
    var isEmailAddress :Bool
    {
        return isValidateByRegex(regular: Regular.emailAddress.rawValue)
    }
    
    var isPhoneNumber : Bool
    {
        return isValidateByRegex(regular: Regular.mobileNumber.rawValue)
    }
    
    var isIdNumber : Bool
    {
        return isValidateByRegex(regular: Regular.idNumber.rawValue)
    }
    
    
    var isNumberPlate : Bool
    {
        return isValidateByRegex(regular: Regular.numberPlate.rawValue)
    }
    
    
}


