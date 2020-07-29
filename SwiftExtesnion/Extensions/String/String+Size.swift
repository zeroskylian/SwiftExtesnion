//
//  String+Size.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/3/11.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    func textSize(constraintWidth: CGFloat ,font:UIFont, insets:UIEdgeInsets = UIEdgeInsets.zero) -> CGSize {
        let constrainedSize = CGSize(width: constraintWidth - insets.left - insets.right, height: CGFloat.greatestFiniteMagnitude)
        let attributes = [NSAttributedString.Key.font: font ]
        let options: NSStringDrawingOptions = [.usesFontLeading, .usesLineFragmentOrigin]
        let bounds = (self as NSString).boundingRect(with: constrainedSize, options: options, attributes: attributes, context: nil)
        return CGSize(width: constraintWidth, height: ceil(bounds.height) + insets.top + insets.bottom)
    }
}
