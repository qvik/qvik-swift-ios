// The MIT License (MIT)
//
// Copyright (c) 2015-2016 Qvik (www.qvik.fi)
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

/// Extensions to the UIColor class
public extension UIColor {
    /**
    Convenience initializer for constructing the UIColor with integer components.
    
    - parameter redInt: value for red (0-255)
    - parameter greenInt: value for green (0-255)
    - parameter blueInt: value for blue (0-255)
    - parameter alpha: value for alpha (0-1.0)
    */
    convenience init(redInt: Int, greenInt: Int, blueInt: Int, alpha: Double) {
        self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
    }

    /**
    Convenience initializer for creating a UIColor from a hex string; accepted formats are
    RRGGBB, RRGGBBAA, #RRGGBB, #RRGGBBAA. If an invalid input is given as the hex string,
    the color is initialized to white.
    
     - parameter hexString: the RGB ("#RRGGBB") or RGBA ("#RRGGBBAA") string
    */
    convenience init(hexString: String) {
        var hexString = hexString

        if hexString.hasPrefix("#") {
            hexString = hexString.substring(startIndex: 1)
        }

        if (hexString.count != 6) && (hexString.count != 8) {
            // Color string is invalid format; return white
            self.init(white: 1.0, alpha: 1.0)
        } else {
            // If the format is RRGGBB instead of RRGGBBAA, use FF as alpha component
            if hexString.count == 6 {
                hexString = "\(hexString)FF"
            }

            let scanner = Scanner(string: hexString)
            var rgbaValue: UInt32 = 0
            if scanner.scanHexInt32(&rgbaValue) {
                let red = (rgbaValue & 0xFF000000) >> 24
                let green = (rgbaValue & 0x00FF0000) >> 16
                let blue = (rgbaValue & 0x0000FF00) >> 8
                let alpha = rgbaValue & 0x000000FF

                self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0,
                          blue: CGFloat(blue) / 255.0, alpha: CGFloat(alpha) / 255.0)
            } else {
                // Parsing the hex string failed; return white
                self.init(white: 1.0, alpha: 1.0)
            }
        }
    }

    /**
     Convenience initializer for creating a UIColor from an integer value, eg. 0x0000FF, with alpha = 1.
     
     - parameter value: the color value as integer
     */
    convenience init(value: Int) {
        self.init(redInt: (value >> 16) & 0xff, greenInt: (value >> 8) & 0xff, blueInt: value & 0xff, alpha: 1)
    }
}
