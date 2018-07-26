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
import XCTest

class CGRectExtensionsTests: XCTestCase {

    func testScale() {
        let rect = CGRect(x: 5, y: 10, width: 20, height: 20)
        let scaled = rect.scaled(x: 2, y: 2)

        XCTAssert(scaled.minX == -5)
        XCTAssert(scaled.minY == 0)
        XCTAssert(scaled.width == 40)
        XCTAssert(scaled.height == 40)
    }

    func testDimensions() {
        var r = CGRect(x: 10, y: 10, width: 10, height: 10)
        XCTAssert(r.width == 10)
        XCTAssert(r.height == 10)
        r.x = 20
        XCTAssert(r.x == 20)
        r.y = 30
        XCTAssert(r.y == 30)
    }
}
