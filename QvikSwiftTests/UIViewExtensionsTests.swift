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

import Foundation
import UIKit
import XCTest

class UIViewExtensionsTests: XCTestCase {

    func testSnapshot() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        let image = view.snapshot()
        XCTAssert(image.size.width == 300)
        XCTAssert(image.size.height == 300)
    }

    func testFrameDimensionAccess() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        view.x = 10
        XCTAssert(view.frame.origin.x == 10)
        view.y = 20
        XCTAssert(view.frame.origin.y == 20)
        view.width = 10
        XCTAssert(view.frame.size.width == 10)
        view.height = 20
        XCTAssert(view.frame.size.height == 20)
    }
}
