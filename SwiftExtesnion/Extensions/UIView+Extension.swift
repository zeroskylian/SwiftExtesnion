//
//  UIView+Extension.swift
//  YimmortalTool
//
//  Created by Yimmortal on 2017/11/30.
//  Copyright © 2017年 YikeNetwork. All rights reserved.
//

import UIKit

extension UIView {
    /// x坐标
    var x: CGFloat {
        set {
            frame = CGRect.init(x: newValue, y: y, width: width, height: height)
        } get {
            return frame.origin.x
        }
    }
    
    /// 横向最大值
    var maxX: CGFloat {
        get {
            return frame.maxX
        }
    }
    
    /// 纵向最大值
    var maxY: CGFloat {
        get {
            return frame.maxY
        }
    }
    
    /// y坐标
    var y: CGFloat {
        set {
            frame = CGRect.init(x: x, y: newValue, width: width, height: height)
        } get {
            return frame.origin.y
        }
    }
    
    /// 宽度
    var width: CGFloat {
        set {
            frame = CGRect.init(x: x, y: y, width: newValue, height: height)
        } get {
            return frame.size.width
        }
    }
    
    /// 高度
    var height: CGFloat {
        set {
            frame = CGRect.init(x: x, y: y, width: width, height: newValue)
        } get {
            return frame.size.height
        }
    }
    
    /// 大小
    var size: CGSize {
        set {
            frame = CGRect.init(origin: origin, size: newValue)
        } get {
            return frame.size
        }
    }
    
    /// 起始位置
    var origin: CGPoint {
        set {
            frame = CGRect.init(origin: newValue, size: size)
        } get {
            return frame.origin
        }
    }
    
    /// 中心的x坐标
    var centerX: CGFloat {
        set {
            center = CGPoint.init(x: newValue, y: centerY)
        } get {
            return center.x
        }
    }
    
    /// 中心的y坐标
    var centerY: CGFloat {
        set {
            center = CGPoint.init(x: centerX, y: newValue)
        } get {
            return center.y
        }
    }
    
    /// 安全区上
    var safeTop: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return safeAreaInsets.top
            } else {
                return 20
            }
        }
    }
    
    /// 安全区左
    var safeLeft: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return safeAreaInsets.left
            } else {
                return 0
            }
        }
    }
    
    /// 安全区下
    var safeBottom: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return safeAreaInsets.bottom
            } else {
                return 0
            }
        }
    }
    
    /// 安全区右
    var safeRight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return safeAreaInsets.right
            } else {
                return 0
            }
        }
    }
    
    /// 当前展示页面所属
    var currentViewController: UIViewController? {
        let currentView: UIView? = UIApplication.shared.getKeyWindow()?.subviews.last
        let responder = currentView?.next
        if (responder?.isKind(of: UIViewController.classForCoder()))! {
            return responder as? UIViewController
        }
        return nil
    }
    
    /// 当前视图所属控制器
    var viewController: UIViewController? {
        if let responder = next {
            if responder.isKind(of: UIViewController.self) {
                return responder as? UIViewController
            }
        }
        return nil
    }
}

extension UIView
{
    
    /// 添加单边圆角
    ///
    /// - Parameters:
    ///   - corners: corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))
        
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}

