// The MIT License (MIT)
//
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

import Accelerate
import Foundation
import ImageIO
import UIKit

/// Extensions to the UIImage class
public extension UIImage {
    /// Provides a shorthand for image width.
    var width: CGFloat {
        return self.size.width
    }

    /// Provides a shorthand for image height.
    var height: CGFloat {
        return self.size.height
    }

    /**
     Returns an image with orientation 'removed', ie. rendered again so that
     imageOrientation is always 'Up'. If this was the case already, the original image is returned.
     
     - returns: a copy of this image with orientation setting set to 'up'.
     */
    func imageWithNormalizedOrientation() -> UIImage {
        if imageOrientation == .up {
            return self
        }

        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        draw(in: rect)

        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return normalizedImage!
    }

    /**
     Returns an scaled-down (to the max size) image of the original image, or the
     original image if max size was not exceeded. Aspect ratio is preserved.
     
     - parameter maxSize: maximum size for the new image
     - parameter imageScale: value for UIImage.scale. Specify 0.0 to match the scale of the device's screen.
     - returns: scaled-down image
     */
    func scaleDown(maxSize: CGSize, imageScale: CGFloat = 1.0) -> UIImage {
        let myWidth = self.size.width
        let myHeight = self.size.height

        if maxSize.height >= myHeight && maxSize.width >= myWidth {
            return self
        }

        let fittingSize = self.size.aspectSizeToFit(maxDimensions: maxSize)

        return scaleTo(size: fittingSize, imageScale: imageScale)
    }

    /**
     Returns a scaled version of this image that 'aspect-fits' inside a given size. Aspect ratio is retained.
     
     - parameter sizeToFit: max dimensions for the scaled image.
     - parameter imageScale: value for UIImage.scale. Specify 0.0 to match the scale of the device's screen.
     - returns: scaled image
     */
    func scaleToFit(sizeToFit: CGSize, imageScale: CGFloat = 1.0) -> UIImage {
        let fittingSize = self.size.aspectSizeToFit(maxDimensions: sizeToFit)

        return scaleTo(size: fittingSize, imageScale: imageScale)
    }

    /**
     Returns a scaled version of this image. The image is stretched to the given size, thus possibly 
     changing the aspect ratio.
     
     - parameter scaledSize: size for the scaled image. Specify ```imageScale: 1.0``` to make this exact pixel size.
     - parameter imageScale: value for UIImage.scale. Specify 0.0 to match the scale of the device's screen.
     - returns: scaled-down image
     */
    func scaleTo(size: CGSize, imageScale: CGFloat = 1.0) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, imageScale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage!
    }

    /**
     Crops the image to a square; from the middle of the original image, using the largest
     possible square area that fits in the original image.
     
     - returns: the cropped image. Note that the dimensions may be off by +-1 pixels.
     */
    func cropImageToSquare() -> UIImage {
        let contextImage: UIImage = UIImage(cgImage: self.cgImage!)
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
        let imageRef: CGImage = contextImage.cgImage!.cropping(to: rect)!
        let image: UIImage = UIImage(cgImage: imageRef, scale: self.scale, orientation: self.imageOrientation)

        return image
    }

    /// Blur algorithms
    enum BlurAlgorithm {
        case boxConvolve
        case tentConvolve
    }

    /**
     Returns a blurred version of the image.
     
     - parameter radius: radius of the blur kernel, in pixels.
     - parameter algorithm: blur algorithm to use. .TentConvolve is faster than .BoxConvolve.
     - returns: the blurred image.
    */
    func blur(radius: Double, algorithm: BlurAlgorithm = .tentConvolve) -> UIImage {
        let imageRect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)

        func createEffectBuffer(_ context: CGContext) -> vImage_Buffer {
            let data = context.data
            let width = vImagePixelCount(context.width)
            let height = vImagePixelCount(context.height)
            let rowBytes = context.bytesPerRow

            return vImage_Buffer(data: data, height: height, width: width, rowBytes: rowBytes)
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        let effectInContext = UIGraphicsGetCurrentContext()
        effectInContext?.scaleBy(x: 1.0, y: -1.0)
        effectInContext?.translateBy(x: 0, y: -self.size.height)
        effectInContext?.draw(self.cgImage!, in: imageRect) // this takes time
        var effectInBuffer = createEffectBuffer(effectInContext!)

        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let effectOutContext = UIGraphicsGetCurrentContext()
        var effectOutBuffer = createEffectBuffer(effectOutContext!)

        let inputRadius = CGFloat(radius) * UIScreen.main.scale
        let f = inputRadius * 3.0 * CGFloat(sqrt(2 * Double.pi))
        var radius = UInt32(floor((f / 4) + 0.5))
        if radius % 2 != 1 {
            radius += 1 // force radius to be odd
        }

        let imageEdgeExtendFlags = vImage_Flags(kvImageEdgeExtend)

        if algorithm == .boxConvolve {
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
        } else {
            vImageTentConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, nil, imageEdgeExtendFlags)
        }

        let effectImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        UIGraphicsEndImageContext()

        return effectImage!
    }

    /**
     Creates an animated image from GIF data.
     
     - parameter gifData: The GIF image data
     - parameter frameDuration: The duration for each frame, in seconds. Default is 0.1.
     */
    class func animatedImage(gifData: Data, frameDuration: TimeInterval = 0.1) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(gifData as CFData, nil) else {
            return nil
        }

        let numFrames = CGImageSourceGetCount(source)
        var frames = [UIImage]()

        for i in 0..<numFrames {
            // Extract the image frame
            guard let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) else {
                continue
            }
            frames.append(UIImage(cgImage: cgImage))
        }

        return UIImage.animatedImage(with: frames, duration: frameDuration * Double(numFrames))
    }
}
