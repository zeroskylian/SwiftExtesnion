//
//  UINavigationController+Backgound.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/4/22.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import UIKit
import ObjectiveC.runtime

extension UINavigationController
{
    private struct AssociatedKeys{
        static var navigationControllerBackgroundView = "com.lian.UINavigationControllerBackgroundView"
    }
    
    var backgroundView :UIView?
    {
        if let view = objc_getAssociatedObject(self, &AssociatedKeys.navigationControllerBackgroundView) as? UIView
        {
            return view
        }else
        {
            var bgView:UIView? = nil
            for view in navigationBar.subviews
            {
                if #available(iOS 10.0 ,*){
                    if view.className == "_UIBarBackground" ||  view.className == "UIBarBackground" {
                        bgView = view
                        break
                    }
                }else
                {
                    if view.className == "_UINavigationBarBackground" ||  view.className == "UINavigationBarBackground" {
                        bgView = view
                        break
                    }
                }
            }
            if let bgView = bgView
            {
                objc_setAssociatedObject(self, &AssociatedKeys.navigationControllerBackgroundView, bgView, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                return bgView
            }else
            {
                return nil
            }
            
        }
    }
}
