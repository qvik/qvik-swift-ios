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

class NSDateFormatterExtensionsTests: XCTestCase {
    func testParser() {
        let f = DateFormatter.iso8601ZFormatter()
        let date = f.date(from: "2008-05-11T15:30:02.123Z")
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let c = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: date!)

        let millis = round(Double(c.nanosecond!) / 1000000.0)

        XCTAssert(c.year == 2008)
        XCTAssert(c.month == 5)
        XCTAssert(c.day == 11)
        XCTAssert(c.hour == 15)
        XCTAssert(c.minute == 30)
        XCTAssert(c.second == 02)
        XCTAssert(millis == 123)
    }

    func testRender() {
        let f = DateFormatter.iso8601ZFormatter()
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        calendar.timeZone = TimeZone(identifier: "UTC")!

        var c = DateComponents()
        c.year = 2011
        c.month = 10
        c.day = 12
        c.hour = 19
        c.minute = 26
        c.second = 45
        let date = calendar.date(from: c)
        let s = f.string(from: date!)
        XCTAssert(s == "2011-10-12T19:26:45.000Z")
    }
}
