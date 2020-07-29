//
//  UIImage+Orientation.swift
//  UiOSProject
//
//  Created by 廉鑫博 on 2019/4/22.
//  Copyright © 2019 廉鑫博. All rights reserved.
//

import UIKit

extension UIImage
{
    
    /// fix image orientation
    /// 拍照上传图片是反的话使用该方法
    /// - Returns: correct imagg
    func fixOrientation() -> UIImage?
    {
        if imageOrientation == .up {
            return self
        }
        
        var transform = CGAffineTransform.identity
        switch imageOrientation {
        case .down,.downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height).rotated(by: CGFloat(Double.pi))
        case .left,.leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0).rotated(by: CGFloat(Double.pi / 2))
        case .right,.rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height).rotated(by: -CGFloat(Double.pi / 2))
        default:
            break
        }
        
        switch imageOrientation {
        case .upMirrored,.downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0).scaledBy(x: -1, y: 1)
        case .rightMirrored,.leftMirrored:
            transform = transform.translatedBy(x: size.height, y: 0).scaledBy(x: -1, y: 1)
        default:
            break
        }
        if let cgImage = cgImage,let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue) {
            
            
            ctx.concatenate(transform)
            switch imageOrientation {
            case .left,.leftMirrored,.rightMirrored,.right:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
            default:
                ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            }
            if let cgImg = ctx.makeImage(){
                return UIImage(cgImage: cgImg)
            }
        }
        return nil
    }
    
    
    func rotate(to orientation:UIImage.Orientation) -> UIImage?
    {
        func swapWidthAndHeight(_ Rect:CGRect) ->CGRect
        {
            var rect = Rect
            let swap = rect.size.width
            rect.size.width = rect.size.height
            rect.size.height = swap
            return rect
        }
        
        if orientation == .up{
            return self
        }
        guard let imag = cgImage else{
            return nil
        }
        var bnds = CGRect.zero
        var rect = CGRect.zero
        var transform = CGAffineTransform.identity
        rect.size.width = CGFloat(imag.width)
        rect.size.height = CGFloat(imag.height)
        
        bnds = rect
        
        switch orientation {
            
        case .up:
            return self
        case .upMirrored:
            transform = transform.translatedBy(x: rect.size.width, y: 0).scaledBy(x: -1, y: 1)
        case .down:
            transform = transform.translatedBy(x: rect.size.width, y: rect.size.height).rotated(by: CGFloat(Double.pi))
        case .downMirrored:
            transform = transform.translatedBy(x: 0, y: rect.size.height).scaledBy(x: 1, y: -1)
        case .left:
            bnds = swapWidthAndHeight(bnds)
            transform = transform.translatedBy(x: 0, y: rect.width).rotated(by: CGFloat(Double.pi * 3 / 2))
        case .leftMirrored:
            bnds = swapWidthAndHeight(bnds)
            transform = transform.translatedBy(x: rect.size.height, y: rect.size.width).scaledBy(x: -1, y: 1).rotated(by: CGFloat(Double.pi * 3 / 2))
        case .right:
            bnds = swapWidthAndHeight(bnds)
            transform = transform.translatedBy(x: rect.size.height, y: 0).rotated(by: CGFloat(Double.pi / 2))
        case .rightMirrored:
            bnds = swapWidthAndHeight(bnds)
            transform = transform.scaledBy(x: -1, y: 1).rotated(by: CGFloat(Double.pi / 2))
            
        @unknown default:
            return self
        }
        
        UIGraphicsBeginImageContext(bnds.size)
        guard let ctxt = UIGraphicsGetCurrentContext() else{
            return nil
        }
        
        switch orientation {
        case .left,.leftMirrored,.right,.rightMirrored:
            ctxt.scaleBy(x: -1, y: 1)
            ctxt.translateBy(x: -rect.size.height, y: 0)
        default:
            ctxt.scaleBy(x: 1, y: -1)
            ctxt.translateBy(x: 0, y: -rect.size.height)
        }
        
        ctxt.concatenate(transform)
        ctxt.draw(imag, in: rect)
        
        let copy = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return copy
    }
    
    
    
    
    
    
}
