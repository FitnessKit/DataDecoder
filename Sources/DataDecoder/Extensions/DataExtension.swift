//
//  DataExtension.swift
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

//MARK: - Values
extension Data {

    init<T>(from value: T) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }

    func scanValue<T>(start: Int, type: T.Type) -> T where T: ExpressibleByIntegerLiteral {
        let value = self.subdata(in: start..<start + MemoryLayout<T>.size)
        return value.to(type: type.self)
    }

    func scanValue<T>(index: inout Int, type: T.Type) -> T? where T: ExpressibleByIntegerLiteral {
        let scanIdx = index
        let toSize = scanIdx + MemoryLayout<T>.size
        if toSize > self.count {
            return nil
        }

        index = index + MemoryLayout<T>.size
        let value = self.subdata(in: scanIdx..<toSize)
        return value.to(type: type.self) as T
    }

    func to<T>(type: T.Type) -> T? where T: ExpressibleByIntegerLiteral {
        var value: T = 0
        guard count >= MemoryLayout.size(ofValue: value) else { return nil }
        _ = Swift.withUnsafeMutableBytes(of: &value, { copyBytes(to: $0)} )
        return value
    }
    
    func to<T>(type: T.Type) -> T where T: ExpressibleByIntegerLiteral {
        var value: T = 0
        _ = Swift.withUnsafeMutableBytes(of: &value, { copyBytes(to: $0)} )
        return value as T
    }
}

//MARK: - Strings
extension Data {

    var safeStringValue: String? {

        var maybeString: String?

        if self[self.count - 1] == 0x00 {
            maybeString = String(data: self, encoding: .utf8)
        } else {
            maybeString = String(data: self, encoding: .ascii)
        }

        return maybeString
    }

}
