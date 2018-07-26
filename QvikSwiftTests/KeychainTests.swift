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

class KeychainTests: XCTestCase {
    var keychain: Keychain!

    override func setUp() {
        super.setUp()

        keychain = Keychain(serviceName: "qvikswift.tests", accessMode: kSecAttrAccessibleAlways as String)
    }

    override func tearDown() {
        super.tearDown()

        keychain = nil
    }

    func testAddStringKey() {
        let key = "my-test-key"
        let value = "My test string öäå ÖÄÅ"

        defer {
            // Cleanup
            do {
                try keychain.remove(key: key)
            } catch {
                print("Error at cleanup: \(error)")
                XCTAssert(false)
            }
        }

        do {
            try keychain.addValue(key: key, value: value)
            let readValue = try keychain.getValue(key: key)

            XCTAssert(readValue == value)
        } catch {
            print("Caught exception: \(error)")
            XCTAssert(false)
        }
    }

    func testAddingEmptyData() {
        let key = "my-test-key"
        let data = Data()

        defer {
            // Cleanup
            do {
                try keychain.remove(key: key)
            } catch {
                print("Error at cleanup: \(error)")
                XCTAssert(false)
            }
        }

        do {
            try keychain.addData(key: key, data: data)
            let readData = try keychain.getData(key: key)

            XCTAssert(readData?.isEmpty ?? false)
        } catch {
            print("Caught exception: \(error)")
            XCTAssert(false)
        }
    }

    func testUpdateValue() {
        let key = "my-test-key"
        let value = "My test string öäå ÖÄÅ"
        let newValue = "öäå Foo new value!"

        defer {
            // Cleanup
            do {
                try keychain.remove(key: key)
            } catch {
                print("Error at cleanup: \(error)")
                XCTAssert(false)
            }
        }

        do {
            try keychain.addValue(key: key, value: value)
            try keychain.updateValue(key: key, newValue: newValue)
            let readValue = try keychain.getValue(key: key)

            XCTAssert(readValue == newValue)
        } catch {
            print("Caught exception: \(error)")
            XCTAssert(false)
        }
    }

    func testRemoveValue() {
        let key = "my-test-key"
        let value = "My test string öäå ÖÄÅ"

        defer {
            // Cleanup
            do {
                try keychain.remove(key: key)
            } catch {
                print("Error at cleanup: \(error)")
                XCTAssert(false)
            }
        }

        do {
            try keychain.addValue(key: key, value: value)
            try keychain.remove(key: key)
            let readValue = try keychain.getValue(key: key)

            XCTAssert(readValue == nil)
        } catch {
            print("Caught exception: \(error)")
            XCTAssert(false)
        }
    }
}
