//
//  Notification+Name.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2018/7/13.
//  Copyright © 2018年 廉鑫博. All rights reserved.
//

import Foundation


enum YourProjectNotification: String, Hashable
{
    case someChangeNoti
    
    var stringValue: String {
        return "XL" + rawValue
    }
    
    var notificationName: Notification.Name {
        return Notification.Name(stringValue)
    }
    
}

extension NotificationCenter {
    static func post(customeNotification name: YourProjectNotification, object: Any? = nil){
        var dic:[YourProjectNotification:Any]? = nil
        if let obj = object
        {
            dic = [name:obj]
        }
        NotificationCenter.default.post(name: name.notificationName, object: object ,userInfo: dic)
    }
    
    
    static func addObserver(_ observer: Any, selector aSelector: Selector, customeNotification aName: YourProjectNotification, object anObject: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: aSelector, name: aName.notificationName, object: anObject)
    }
    
    static func addObserver(customeNotification aName: YourProjectNotification, object obj: Any? = nil, queue: OperationQueue? = .main, using block: @escaping (Notification) -> Void) -> NSObjectProtocol
    {
        return NotificationCenter.default.addObserver(forName: aName.notificationName, object: obj, queue: queue, using: block)
    }
    
    
}

extension Notification
{
    func getUserInfo(customeNotification name: YourProjectNotification) -> Any? {
        return userInfo?[name]
    }
}
