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
import XCTest

class CGSizeExtensionsTests: XCTestCase {
    func testAspectSizeToFit() {
        // Check that fitted size dimensions fit max size AND aspect ratio is retained
        let maxSize = CGSize(width: 800, height: 800)
        let size2 = CGSize(width: 1234, height: 950)
        let fitted2 = size2.aspectSizeToFit(maxDimensions: maxSize)
        XCTAssert(fitted2.width <= maxSize.width)
        XCTAssert(fitted2.height <= maxSize.height)
        let aspect2 = size2.width / size2.height
        let fittedAspect2 = fitted2.width / fitted2.height
        XCTAssert(abs(fittedAspect2 - aspect2) < 0.0001)
    }
}
