//
//  ToggleByte.swift
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


/// ANT Toggle Byte
public struct ANTToggleByte {
    public var pageNumber: UInt8
    public var toggle: Bool

    public var uint8Value: UInt8 {
        var value: UInt8 = pageNumber
        value |= UInt8(toggle == true ? 1 : 0) << 7

        return UInt8(value)
    }

    public init(_ value: UInt8) {
        self.pageNumber = (value & 0x7F)
        self.toggle = ((value >> 7) & 0x7F).boolValue
    }

    public init(pageNumber: UInt8, toggled: Bool) {
        self.pageNumber = pageNumber
        self.toggle = toggled
    }
}


internal extension UInt8 {

    var boolValue: Bool {
        switch self {
        case 0x01:
            return true
        case 0x00:
            return false
        default:
            return false
        }
    }
}
