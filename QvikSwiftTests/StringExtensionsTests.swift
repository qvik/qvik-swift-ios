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
import XCTest

class StringExtensionsTests: XCTestCase {

    func testTrim() {
        XCTAssert(" foo bar ".trim() == "foo bar")
        XCTAssert("foo\nbar".trim() == "foo\nbar")
        XCTAssert("http://foo/bar ".trim() == "http://foo/bar")
        XCTAssert("\rfoo\nbar \n".trim() == "foo\nbar")
    }

    func testUrlEncoding() {
        let s = "foo bar kek! bur & diu : dau"
        let encoded = s.urlEncoded
        XCTAssert(encoded == "foo%20bar%20kek!%20bur%20&%20diu%20:%20dau")
    }

    func testContains() {
        let subs = "foo"
        let s1 = "Hello, world, this is foo bar!"
        let s2 = "Oh fo oo"
        XCTAssert(s1.contains(subs))
        XCTAssert(!s2.contains(subs))
    }

    func testSplit() {
        let string = "123 4567 abcdef"
        let split = string.split(" ")
        XCTAssert(split[0] == "123")
        XCTAssert(split[1] == "4567")
        XCTAssert(split[2] == "abcdef")
    }

    func testSubstring() {
        let expected1 = " cat"
        let s1 = "A dog, cat and mouse had a party."
        XCTAssert(s1.substring(startIndex: 6, length: 4) == expected1)
        let expected2 = "the world."
        let s2 = "It's the end of the world."
        XCTAssert(s2.substring(startIndex: 16) == expected2)
    }

    func testSubscripts() {
        let s1 = "abcdef"
        XCTAssert(s1[1] == "b")
        XCTAssert(s1[2..<4] == "cd")
    }

    func testSplitEqually() {
        let s1 = "123abcdef"
        let parts1 = s1.splitEqually(length: 3)
        XCTAssert(parts1.count == 3, "Invalid part count")
        XCTAssert(parts1[0] == "123")
        XCTAssert(parts1[1] == "abc")
        XCTAssert(parts1[2] == "def")
        let s2 = "1234567"
        let parts2 = s2.splitEqually(length: 2)
        XCTAssert(parts2.count == 4, "Invalid part count")
        XCTAssert(parts2[0] == "12")
        XCTAssert(parts2[1] == "34")
        XCTAssert(parts2[2] == "56")
        XCTAssert(parts2[3] == "7")
    }

    /*
     The comparison values in testBoundingRect() are what the size of a
     UILabel with the same values ends up being, as manually tested in
     interface builder. The boundingRectWithFont method is expected to
     return sizes not identical to those, but slightly smaller and very
     close.
    */
    func assertRect(_ rect: CGRect, matchesExpectedSize size: CGSize) {
        XCTAssert(rect.origin == CGPoint(x: 0, y: 0))
        XCTAssert(rect.width > size.width - 1)
        XCTAssert(rect.width <= size.width)
        XCTAssert(rect.height > size.height - 1)
        XCTAssert(rect.height <= size.height)
    }

    func testBoundingRect() {
        let str1 = "Label"
        let font1 = UIFont(name: "HelveticaNeue", size: 17)!
        let rect1 = str1.boundingRect(font: font1)
        let size1 = CGSize(width: 42, height: 20)
        assertRect(rect1, matchesExpectedSize: size1)
        let str2 = "Longer string with bold font"
        let font2 = UIFont(name: "Courier-Bold", size: 12)!
        let rect2 = str2.boundingRect(font: font2)
        let size2 = CGSize(width: 202, height: 12)
        assertRect(rect2, matchesExpectedSize: size2)
        let str3 = "Even longer string with size constraint breaking it to multiple lines"
        let font3 = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 20)!
        let constraint3 = CGSize(width: 120, height: CGFloat.greatestFiniteMagnitude)
        let rect3 = str3.boundingRect(font: font3, constrainedToSize: constraint3)
        let size3 = CGSize(width: 120, height: 111)
        assertRect(rect3, matchesExpectedSize: size3)
    }
}
