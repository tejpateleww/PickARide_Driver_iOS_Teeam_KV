//
//  UIImage+Extension.swift
//  HC Pro Patient
//
//  Created by Shraddha Parmar on 24/09/20.
//  Copyright © 2020 EWW071. All rights reserved.
//

import Foundation
import  UIKit

extension UIImage{
    public func maskWithColor(color: UIColor) -> UIImage {

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        let rect = CGRect(origin: CGPoint.zero, size: size)

        color.setFill()
        self.draw(in: rect)

        context.setBlendMode(.sourceIn)
        context.fill(rect)

        let resultImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }

    var grayscaled: UIImage?{
        let context = CIContext(options: nil)
        if let filter = CIFilter(name: "CIPhotoEffectNoir") {
            filter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
            if let output = filter.outputImage {
                if let cgImage = context.createCGImage(output, from: output.extent) {
                    return UIImage(cgImage: cgImage)
                }
            }
        }
        return nil
    }
}
