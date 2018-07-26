//: Playground - noun: a place where people can play

import UIKit

extension Data {
    public func floatValue(bigEndian: Bool = true) -> Float? {
        if self.count != 4 {
            // Incorrect amount of bytes to represent a 32bit Float type
            return nil
        }

        if bigEndian {
            return Float(bitPattern: UInt32(bigEndian: self.withUnsafeBytes { $0.pointee }))
        } else {
            return Float(bitPattern: UInt32(littleEndian: self.withUnsafeBytes { $0.pointee }))
        }
    }

    convenience init(floatValue: Float) {
        let bits = value.bitPattern.bigEndian
        self.init(bytes: &bits, count: 4)
        //let data = Data(bytes: &bits, count: 4)
    }
}

let float1 = 123.456
let data1 = Data(floatValue: float1)

print(data1)
