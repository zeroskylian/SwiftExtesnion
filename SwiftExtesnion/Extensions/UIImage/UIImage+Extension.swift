//
//  UIImage+Extension.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/4/22.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import UIKit

// MARK: - generateImage
extension UIImage
{
    func generateImage(color:UIColor,size:CGSize) -> UIImage?
    {
        UIGraphicsBeginImageContext(size)
        if let context: CGContext = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect.init(origin: CGPoint.zero, size: size))
            if let img: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return img
            }
        }
        UIGraphicsEndImageContext()
        return nil
    }
    
    
}

// MARK: - base64
extension UIImage
{
    /// 转换为base64字符串
    ///
    /// - Returns: base64字符串
    func convertToBase64String() -> String? {
        let imgData: Data? = self.pngData()
        return imgData?.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 0))
    }
    
    /// 使用base64创建图片
    ///
    /// - Parameter base64Str: base64字符串
    /// - Returns: 创建好的图片
    class func image(base64Str: String) -> UIImage? {
        var base64Str = base64Str
        if base64Str.hasPrefix("data:image") {
            guard let base64SubStr = base64Str.split(separator: ",").last else { return nil }
            base64Str = String.init(base64SubStr)
        }
        if let imgData: Data = Data.init(base64Encoded: base64Str, options: Data.Base64DecodingOptions.init()) {
            return UIImage.init(data: imgData)
        }
        return nil
    }
    
    
    func grayscaleImage() ->UIImage?
    {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let colorSpace = CGColorSpaceCreateDeviceGray()
        if let cgImage = cgImage,let content = CGContext.init(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.none.rawValue){
            content.draw(cgImage, in: rect)
            if let grayScale = content.makeImage(){
                return UIImage(cgImage: grayScale)
            }else
            {
                return nil
            }
        }
        return nil
        
    }
}

