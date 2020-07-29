//
//  Dictionary+Extension.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/4/22.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import Foundation

extension Dictionary {
    
    /// 字典转JSON
    ///
    /// - Returns: 转换好的JSON
    /// - Throws: 错误信息
    func convertToJSONString() throws -> String? {
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String.init(data: jsonData, encoding: .utf8)
        } catch {
            throw error
        }
    }
}

