//
//  Bundle+Extension.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/4/22.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import Foundation

extension Bundle
{
    /// Document主目录URL
    class var documentDirectoryURL : URL?  {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    /// Caches主目录URL
    class var cachesDirectoryURL: URL? {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last
    }
    
    
    /// Document主目录Path
    class var documentDirectoryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last
    }
    /// Caches主目录Path
    class var cachesDirectoryPath: String? {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last
    }
}
