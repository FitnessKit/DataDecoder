//
//  Nibble.swift
//  DataDecoder
//
//  Created by Kevin Hoogheem on 3/31/17.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

/// Nibble
public struct Nibble {
    public var lower: UInt8
    public var upper: UInt8

    public var uint8Value: UInt8 {
        return (self.upper << 4) | self.lower
    }

    public init(lower: UInt8, upper: UInt8) {
        self.lower = lower
        self.upper = upper
    }

    public init(_ value: UInt8) {
        self.lower = value & 0x0F
        self.upper = ((value >> 4) & 0x0F)
    }
}

extension Nibble: Equatable {

    public static func ==(lhs: Nibble, rhs: Nibble) -> Bool {
        return (lhs.upper == rhs.upper) && (lhs.lower == rhs.lower)
    }
}


///MARK: - UInt8 Extension
public extension UInt8 {

    public var nibbleValue: Nibble {
        return Nibble(self)
    }
}
