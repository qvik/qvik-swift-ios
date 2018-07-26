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

class UIResponderExtensionsTests: XCTestCase {
    fileprivate let window = UIWindow()
    fileprivate let viewController = UIViewController()
    fileprivate let textView = UITextView()

    override func setUp() {
        super.setUp()

        window.addSubview(viewController.view)
        viewController.view.addSubview(textView)
    }

    func testGetCurrentFirstResponder() {
        XCTAssert(textView.becomeFirstResponder())

        // Apparently the responder chain is not updated immediately; so we'll wait for a later 
        // runloop cycle to check the result.
        runOnMainThreadAfter(delay: 0.1) {
            let firstResponder = UIResponder.getCurrentFirstResponder()
            XCTAssert(firstResponder != nil)
            XCTAssert(firstResponder === self.textView)
        }
    }

    func testResignCurrentFirstResponder() {
        XCTAssert(textView.becomeFirstResponder())

        // Apparently the responder chain is not updated immediately; so we'll wait for a later
        // runloop cycle to check the result.
        runOnMainThreadAfter(delay: 0.1) {
            UIResponder.resignCurrentFirstResponder()
            let firstResponder = UIResponder.getCurrentFirstResponder()
            XCTAssert(firstResponder == nil)
        }
    }
}
