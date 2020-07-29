//
//  UIApplication+Extension.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/4/22.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import UIKit


extension UIApplication {
    
    /// 应用程序名称
    var applicationName: String {
        return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String
    }
    
    /// 应用程序版本号
    var applicationVersion: String {
        return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    /// 应用程序的build版本号
    var applicationBuildVersion: String {
        return Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    /// 应用程序的BundleID
    var bundleId: String {
        return Bundle.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
    
    /// 上次打开应用时的版本
    var lastTimeVersion: String? {
        set {
            UserDefaults.standard.set(UIApplication.shared.applicationVersion, forKey: "kLastTimeVersion")
            UserDefaults.standard.synchronize()
        } get {
            return UserDefaults.standard.object(forKey: "kLastTimeVersion") as? String
        }
    }
    
    var topViewController: UIViewController? {
        guard var topViewController = UIApplication.shared.getKeyWindow()?.rootViewController else { return nil }
        
        while let presentedViewController = topViewController.presentedViewController {
            topViewController = presentedViewController
        }
        return topViewController
    }
    
    var topNavigationController: UINavigationController? {
        return topViewController as? UINavigationController
    }
    
    func getKeyWindow() -> UIWindow?
    {
        var window :UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        } else {
            window = UIApplication.shared.keyWindow
        }
        return window
    }
}


