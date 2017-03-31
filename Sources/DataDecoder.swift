//
//  DataDecoder.swift
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


public struct DataDecoder {
    private var decode: Data
    private var index: Int = 0

    public init(_ value: Data) {
        self.index = 0
        self.decode = value
    }

    public mutating func decodeNibble() -> Nibble {
        let value = decode.scanValue(index: &index, type: UInt8.self) ?? 0
        print(value)
        return Nibble(value)
    }

    public mutating func decodeUInt8() -> UInt8 {
        return decode.scanValue(index: &index, type: UInt8.self) ?? 0
    }

    public mutating func decodeUInt16() -> UInt16 {
        return decode.scanValue(index: &index, type: UInt16.self) ?? 0
    }

    public mutating func decodeUInt24() -> Int {
        let val0 = decode.scanValue(index: &index, type: UInt8.self) ?? 0
        let val1 = decode.scanValue(index: &index, type: UInt8.self) ?? 0
        let val2 = decode.scanValue(index: &index, type: UInt8.self) ?? 0

        let value: Int  = Int((val2 << 16) | (val1 <<  8) | val0)
        return value
    }

    public mutating func decodeSInt24() -> Int {
        let val0 = decode.scanValue(index: &index, type: UInt8.self) ?? 0
        let val1 = decode.scanValue(index: &index, type: UInt8.self) ?? 0
        let val2 = decode.scanValue(index: &index, type: UInt8.self) ?? 0

        var value: Int = 0

        if val2 & 0x80 == 1 {
            value = Int(0xff << 24) | Int(val2 << 16) | Int(val1 <<  8) | Int(val0)
        } else {
            value = Int((val2 << 16) | (val1 <<  8) | val0)
        }

        return value
    }

    public mutating func decodeUInt32() -> UInt32 {
        return decode.scanValue(index: &index, type: UInt32.self) ?? 0
    }
    
}
