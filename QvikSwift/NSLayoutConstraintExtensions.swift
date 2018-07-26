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

import UIKit

/// Extensions to the NSLayoutConstraint class.
public extension NSLayoutConstraint {
    /**
     Creates a constraint that defines the relationship between the specified attribute of the given views with constant = 0 by default.
     
     - parameter item: first item
     - parameter toItem: second item
     - parameter attribute: which attribute to create the constraint for
     - parameter constant: constant value to use (0 by default)
     */
    convenience init(item: UIView, toItem: UIView, attribute: NSLayoutAttribute, constant: CGFloat = 0) {
        self.init(item: item, attribute: attribute, relatedBy: .equal, toItem: toItem, attribute: attribute, multiplier: 1, constant: constant)
    }

    /**
     Creates constraints to exactly match the size of the other view, ie. left edge to left edge, top to top, etc.

     - parameter item: first item
     - parameter toItem: second item
     */
    static func match(item: UIView, toItem: UIView) -> [NSLayoutConstraint] {
        return [
            NSLayoutConstraint(item: item, toItem: toItem, attribute: .top),
            NSLayoutConstraint(item: item, toItem: toItem, attribute: .right),
            NSLayoutConstraint(item: item, toItem: toItem, attribute: .bottom),
            NSLayoutConstraint(item: item, toItem: toItem, attribute: .left)
        ]
    }
}
