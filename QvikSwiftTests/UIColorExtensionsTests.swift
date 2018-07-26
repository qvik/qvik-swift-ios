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

import Foundation
import UIKit
import XCTest

class UIColorExtensionsTests: XCTestCase {

    func expectValues(_ color: UIColor, red: Int, green: Int, blue: Int, alpha: Int) {
        var fRed: CGFloat = 0
        var fGreen: CGFloat = 0
        var fBlue: CGFloat = 0
        var fAlpha: CGFloat = 0
        color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        let iRed = Int(fRed * 255)
        let iGreen = Int(fGreen * 255)
        let iBlue = Int(fBlue * 255)
        let iAlpha = Int(fAlpha * 255)

        XCTAssert(iRed == red)
        XCTAssert(iGreen == green)
        XCTAssert(iBlue == blue)
        XCTAssert(iAlpha == alpha)
    }

    func testIntInitializer() {
        let color = UIColor(redInt: 100, greenInt: 120, blueInt: 255, alpha: 0.5)
        expectValues(color, red: 100, green: 120, blue: 255, alpha: 127)
    }

    func testHexStringInitializer() {
        let color = UIColor(hexString: "#11223344")
        expectValues(color, red: 17, green: 34, blue: 51, alpha: 68)
    }

    func testHexInitializer() {
        let color = UIColor(hex: 0x112233)
        expectValues(color, red: 0x11, green: 0x22, blue: 0x33, alpha: 0xFF)
    }
}
