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

public extension Data {
    /**
     Returns a hex string of the bytes of this data, each byte zero-padded to be represented by
     two hex characters.

     - returns: hex string of this data's bytes
    */
    func hexString() -> String {
        return reduce("") { $0 + String(format: "%02x", $1) }
    }

    /**
     Initializes the Data buffer from a 32bit Float.

     - param floatValue: the Float value to store in the Data buffer
     - param bigEndian: whether to store it as big endian (true) or little endian (false)
     */
    init(floatValue: Float, bigEndian: Bool = true) {
        var bits = bigEndian ? floatValue.bitPattern.bigEndian : floatValue.bitPattern.littleEndian
        self.init(bytes: &bits, count: MemoryLayout<Float>.size)
    }

    /**
     Initializes the Data buffer from a 32bit Double.

     - param doubleValue: the Double value to store in the Data buffer
     - param bigEndian: whether to store it as big endian (true) or little endian (false)
     */
    init(doubleValue: Double, bigEndian: Bool = true) {
        var bits = bigEndian ? doubleValue.bitPattern.bigEndian : doubleValue.bitPattern.littleEndian
        self.init(bytes: &bits, count: MemoryLayout<Double>.size)
    }

    /**
     If the Data object is exactly 4 bytes in length, returns a Float represented by the data in the buffer.

     - param bigEndian: true to interpret the data as Big Endian, false to interpret it as Little Endian
     - returns: Represented Float value or nil if incorrect amount of bytes present
     */
    func floatValue(bigEndian: Bool = true) -> Float? {
        if self.count != 4 {
            // Incorrect amount of bytes to represent a 32bit Float type
            return nil
        }

        if bigEndian {
            return Float(bitPattern: UInt32(bigEndian: withUnsafeBytes { $0.load(as: UInt32.self) }))
        } else {
            return Float(bitPattern: UInt32(littleEndian: withUnsafeBytes { $0.load(as: UInt32.self) }))
        }
    }

    /**
     If the Data object is exactly 8 bytes in length, returns a Double represented by the data in the buffer.

     - param bigEndian: true to interpret the data as Big Endian, false to interpret it as Little Endian
     - returns: Represented Double value or nil if incorrect amount of bytes present
     */
    func doubleValue(bigEndian: Bool = true) -> Double? {
        if self.count != 8 {
            // Incorrect amount of bytes to represent a 64bit Double type
            return nil
        }

        if bigEndian {
            return Double(bitPattern: UInt64(bigEndian: withUnsafeBytes { $0.load(as: UInt64.self) }))
        } else {
            return Double(bitPattern: UInt64(littleEndian: withUnsafeBytes { $0.load(as: UInt64.self) }))
        }
    }
}
