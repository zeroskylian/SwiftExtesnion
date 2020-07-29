
//
//  Debug.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2018/10/30.
//  Copyright © 2018 廉鑫博. All rights reserved.
//

import Foundation

public func printLog( _ items: Any..., file:String = #file, line:Int = #line, function:String = #function) {
    #if DEBUG
    print("[Log]:File:\(file) \nLine:\(line) \nFunction:\(function) \n\(items)")
    #endif
}
