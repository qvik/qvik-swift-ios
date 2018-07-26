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

/// Extensions to the String class.
public extension String {
    /**
     Trims all the whitespace-y / newline characters off the begin/end of the string.
     
     - returns: a new string with all the newline/whitespace characters removed from the ends of the original string
     */
    func trim() -> String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }

    /**
    Returns an URL encoded string of this string.
    
    - returns: String that is an URL-encoded representation of this string.
    */
    var urlEncoded: String? {
        return self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }

    /**
    Convenience method for a more familiar name for string splitting.
    
    - parameter separator: string to split the original string by
    - returns: the original string split into parts
    */
    func split(_ separator: String) -> [String] {
        return components(separatedBy: separator)
    }

    /**
    Checks whether the string contains a given substring.
    
    - parameter s: substring to check for
    - returns: true if this string contained the given substring, false otherwise.
    */
    func contains(_ s: String) -> Bool {
        return (self.range(of: s) != nil)
    }

    /**
    Returns a substring of this string from a given index up the given length.
    
    - parameter startIndex: index of the first character to include in the substring
    - parameter length: number of characters to include in the substring
    - returns: the substring
    */
    func substring(startIndex: Int, length: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: startIndex)
        let end = self.index(self.startIndex, offsetBy: startIndex + length)

        return String(self[start..<end])
    }

    /**
    Returns a substring of this string from a given index to the end of the string.
    
    - parameter startIndex: index of the first character to include in the substring
    - returns: the substring from startIndex to the end of this string
    */
    func substring(startIndex: Int) -> String {
        let start = self.index(self.startIndex, offsetBy: startIndex)
        return String(self[start...])
    }

    /**
     Returns the i:th character in the string. 
     
     - parameter i: index of the character to return
     - returns: i:th character in the string
     */
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }

    /**
     Returns a substring matching the given range.

     - parameter r: range for substring to return
     - returns: substring matching the range r
     */
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(start, offsetBy: r.upperBound - r.lowerBound)
        return String(self[start..<end])
    }

    /**
    Splits the string into substring of equal 'lengths'; any remainder string
    will be shorter than 'length' in case the original string length was not multiple of 'length'.
    
    - parameter length: (max) length of each substring
    - returns: the substrings array
    */
    func splitEqually(length: Int) -> [String] {
        var index = 0
        let len = self.count
        var strings: [String] = []

        while index < len {
            let numChars = min(length, (len - index))
            strings.append(self.substring(startIndex: index, length: numChars))

            index += numChars
        }

        return strings
    }

    /**
     Returns the bounding rectangle that drawing required for drawing this string using
     the given font. By default the string is drawn on a single line, but it can be
     constrained to a specific width with the optional parameter constrainedToSize.
     
     - parameter font: font used
     - parameter constrainedToSize: the constraints for drawing
     - returns: the bounding rectangle required to draw the string
     */
    func boundingRect(font: UIFont, constrainedToSize size: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) -> CGRect {
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedStringKey.font: font])
        return attributedString.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
    }

}
