//
//  UIImage+QRCode.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/4/22.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import UIKit

extension UIImage
{
    /// 根据字符串创建高清二维码
    ///
    /// - Parameters:
    ///   - qrString: 需要生成二维码的字符串
    ///   - logoImg: 放在中间的logo
    ///   - border: 二维码尺寸
    /// - Returns: 生成好的二维码图片
    class func createQRImage(qrString: String, logoImg: UIImage?, border: CGFloat) -> UIImage? {
        //  绘制二维码
        guard let data = qrString.data(using: .utf8, allowLossyConversion: false) else { return nil }
        let imgFilter = CIFilter.init(name: "CIQRCodeGenerator")
        imgFilter?.setValue(data, forKey: "inputMessage")
        imgFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let ciImage = imgFilter?.outputImage
        
        /// 绘制颜色
        let colorFilter = CIFilter.init(name: "CIFalseColor")
        colorFilter?.setDefaults()
        colorFilter?.setValue(ciImage, forKey: "inputImage")
        colorFilter?.setValue(CIColor.init(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter?.setValue(CIColor.init(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        
        //  高清二维码
        guard var outImage = colorFilter?.outputImage else { return nil }
        let transform = CGAffineTransform.init(scaleX: 20, y: 20)
        outImage = outImage.transformed(by: transform)
        
        //  最终绘制及加上Logo
        let qrImage = UIImage.init(ciImage: outImage)
        let imgRect = CGRect.init(x: 0, y: 0, width: border, height: border)
        UIGraphicsBeginImageContextWithOptions(imgRect.size, false, UIScreen.main.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        qrImage.draw(in: imgRect)
        if let logoImg = logoImg {
            let logoSize = CGSize.init(width: border * 0.2, height: border * 0.2)
            logoImg.draw(in: CGRect.init(origin: CGPoint.init(x: (border - logoSize.width) / 2, y: (border - logoSize.width) / 2), size: logoSize))
        }
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


