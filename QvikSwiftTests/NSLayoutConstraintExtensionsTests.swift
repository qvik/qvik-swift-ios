// The MIT License (MIT)
//
// Copyright (c) 2016 Qvik (www.qvik.fi)
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

class NSLayoutConstraintTests: XCTestCase {
    func testSimplifiedInitializer() {
        let view = UIView(frame: CGRect.zero)
        let subview = UIView(frame: CGRect.zero)
        view.addSubview(subview)

        let constraint1 = NSLayoutConstraint(item: view, toItem: subview, attribute: .top)
        let constraint2 = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: subview, attribute: .top, multiplier: 1, constant: 0)

        XCTAssert(constraint1.firstItem === constraint2.firstItem)
        XCTAssert(constraint1.firstAttribute == constraint2.firstAttribute)
        XCTAssert(constraint1.relation == constraint2.relation)
        XCTAssert(constraint1.secondItem === constraint2.secondItem)
        XCTAssert(constraint1.secondAttribute == constraint2.secondAttribute)
        XCTAssert(constraint1.multiplier == constraint2.multiplier)
        XCTAssert(constraint1.constant == constraint2.constant)

        let constraint3 = NSLayoutConstraint(item: view, toItem: subview, attribute: .bottom, constant: 10)
        let constraint4 = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: subview, attribute: .bottom, multiplier: 1, constant: 10)

        XCTAssert(constraint3.firstItem === constraint4.firstItem)
        XCTAssert(constraint3.firstAttribute == constraint4.firstAttribute)
        XCTAssert(constraint3.relation == constraint4.relation)
        XCTAssert(constraint3.secondItem === constraint4.secondItem)
        XCTAssert(constraint3.secondAttribute == constraint4.secondAttribute)
        XCTAssert(constraint3.multiplier == constraint4.multiplier)
        XCTAssert(constraint3.constant == constraint4.constant)
    }
}
