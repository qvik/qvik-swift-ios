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

import UIKit

/// Extensions to CGSize type
public extension CGSize {
    /**
     Calculates the maximum size (retaining aspect ratio) to fit the given maximum dimensions. 
     
     - parameter maxDimensions: maximum dimensions to fit the size. neither value can be negative.
     - returns: fitted size with aspect ratio retained
     */
    func aspectSizeToFit(maxDimensions maxSize: CGSize) -> CGSize {
        if (maxSize.width <= 0) || (maxSize.height <= 0) {
            return self
        }

        // Decide how much to scale down by looking at the differences in width/height
        // against the max size
        let xratio = maxSize.width / self.width
        let yratio = maxSize.height / self.height
        let ratio = min(xratio, yratio)

        return self.applying(CGAffineTransform(scaleX: ratio, y: ratio))
    }
}
