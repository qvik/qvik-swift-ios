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

import Foundation

/// Represents a callback for an UIGestureRecognizer
@objc
private class UIGestureRecognizerTarget: NSObject {
    private static var associationKey: UInt8 = 0

    /// Callback function; either with UIGestureRecognizer parameter or none at all
    private let callback: Any?

    /// Constructs with a callback accepting a UIGestureRecognizer parameter
    fileprivate init(callback: @escaping (UIGestureRecognizer) -> Void) {
        self.callback = callback
    }

    /// Constructs with a callback accepting no parameters
    fileprivate init(callback: @escaping () -> Void) {
        self.callback = callback
    }

    /// Receives the gesture and passes it on to the callback
    @objc
    fileprivate func action(_ gestureRecognizer: UIGestureRecognizer) {
        if let callbackWithRecognizer = callback as? ((UIGestureRecognizer) -> Void) {
            callbackWithRecognizer(gestureRecognizer)
        } else if let callback = callback as? (() -> Void) {
            callback()
        }
    }

    /// Associates this instance with an gesture recognizer
    fileprivate func associate(with object: UIGestureRecognizer) {
        objc_setAssociatedObject(object, &UIGestureRecognizerTarget.associationKey, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

/// Extensions to the UIGestureRecognizer class
public extension UIGestureRecognizer {
    /**
     Convenience initializer that accepts a callback closure instead of a selector. The callback
     must accept a UIGestureRecognizer parameter.

     - parameter callbackWithRecognizer: the callback closure that is called when a gesture is recognized.
     */
    convenience init(callbackWithRecognizer: @escaping ((UIGestureRecognizer) -> Void)) {
        let target = UIGestureRecognizerTarget(callback: callbackWithRecognizer)
        self.init(target: target, action: #selector(target.action))
        target.associate(with: self)
    }

    /**
     Convenience initializer that accepts a callback closure instead of a selector. The callback
     must accept no parameters.

     - parameter callback: the callback closure that is called when a gesture is recognized.
     */
    convenience init(callback: @escaping (() -> Void)) {
        let target = UIGestureRecognizerTarget(callback: callback)
        self.init(target: target, action: #selector(target.action))
        target.associate(with: self)
    }
}
