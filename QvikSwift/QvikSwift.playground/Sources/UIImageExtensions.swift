// Copyright (c) 2015 Qvik (www.qvik.fi)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import UIKit

/// Extensions to the UIImage class
public extension UIImage {
    /**
    Returns an scaled-down (to the max size) image of the original image, or the
    original image if max size was not exceeded. Aspect ratio is preserved.
    
    :param: maxSize maximum size for the new image
    :returns: scaled-down image
    */
    func scaleDown(maxSize: CGSize) -> UIImage? {
        let myWidth = self.size.width
        let myHeight = self.size.height

        if maxSize.height >= myHeight && maxSize.width >= myWidth {
            return self
        }

        // Decide how much to scale down by looking at the differences in width/height
        // against the max size
        let xratio = maxSize.width / myWidth
        let yratio = maxSize.height / myHeight
        let ratio = min(xratio, yratio)

        let size = self.size.applying(CGAffineTransform(scaleX: ratio, y: ratio))
        let scale: CGFloat = 0.0 // Automatically use scale factor of main screen

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: size))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }

    /**
    Crops the image to a square; from the middle of the original image, using the largest
    possible square area that fits in the original image.
    
    :returns: the cropped image. Note that the dimensions may be off by +-1 pixels.
     If the original image is a CIImage-backed image or errors occur, this returns nil
    */
    func cropImageToSquare() -> UIImage? {
        guard let cgImage = self.cgImage else {
            return nil
        }

        let contextImage: UIImage = UIImage(cgImage: cgImage)
        guard let contextCgImage = contextImage.cgImage else {
            return nil
        }

        let contextSize: CGSize = contextImage.size

        let posX: CGFloat
        let posY: CGFloat
        let width: CGFloat
        let height: CGFloat

        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            width = contextSize.height
            height = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            width = contextSize.width
            height = contextSize.width
        }

        let rect = CGRect(x: posX, y: posY, width: width, height: height)
        guard let imageRef = contextCgImage.cropping(to: rect) else {
            return nil
        }
        let image = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

        return image
    }
}
