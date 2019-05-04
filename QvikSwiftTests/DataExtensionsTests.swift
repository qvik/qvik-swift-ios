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

class DataExtensionsTests: XCTestCase {

    func testToHexString() {
        let data = Data([0x20, 0x30, 0x41, 0x51])
        let hex = data.hexString()
        XCTAssert(hex == "20304151")
    }

    /// Helper function for testing storing a Float into a Data
    func myTestStoreFloat(bigEndian: Bool) {
        let value = Float(123.456)
        let data = Data(floatValue: value, bigEndian: bigEndian)
        XCTAssert(data.count == MemoryLayout<Float>.size)

        guard let storedValue = data.floatValue(bigEndian: bigEndian) else {
            XCTAssert(false, "Failed to extract value from Data")
            return
        }
        XCTAssert(value.bitPattern == storedValue.bitPattern)
        XCTAssert(value == storedValue)
    }

    /// Helper function for testing storing a Double into a Data
    func myTestStoreDouble(bigEndian: Bool) {
        let value = Double(123456.123456789)
        let data = Data(doubleValue: value, bigEndian: bigEndian)
        XCTAssert(data.count == MemoryLayout<Double>.size)

        guard let storedValue = data.doubleValue(bigEndian: bigEndian) else {
            XCTAssert(false, "Failed to extract value from Data")
            return
        }
        XCTAssert(value.bitPattern == storedValue.bitPattern)
        XCTAssert(value == storedValue)
    }

    func testStoreFloatBigEndian() {
        myTestStoreFloat(bigEndian: true)
    }

    func testStoreFloatLittleEndian() {
        myTestStoreFloat(bigEndian: false)
    }

    func testStoreDoubleBigEndian() {
        myTestStoreDouble(bigEndian: true)
    }

    func testStoreDoubleLittleEndian() {
        myTestStoreDouble(bigEndian: false)
    }
}
