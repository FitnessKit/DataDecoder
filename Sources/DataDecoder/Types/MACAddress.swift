//
//  MACAddress.swift
//  DataDecoder
//
//  Created by Kevin Hoogheem on 4/1/17.
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


public struct MACAddress {

    fileprivate(set) public var stringValue: String

    public var dataValue: Data {
        let substring = stringValue.replacingOccurrences(of: ":", with: "")
        //let da = Data(bytes: [Character](substring.characters).byteArray)

        return substring.data(using: .utf8)!
    }

    public init(string: String) {
        self.stringValue = string.uppercased()
    }

    public init(data: Data) {

        self.stringValue = "00:00:00:00:00:00"

        if data.count == 6 {
            self.stringValue = String(format: "%02X:%02X:%02X:%02X:%02X:%02X",
                                      data[0],
                                      data[1],
                                      data[2],
                                      data[3],
                                      data[4],
                                      data[5]).uppercased()
        }
    }
}

extension MACAddress: Equatable {

    public static func ==(lhs: MACAddress, rhs: MACAddress) -> Bool {
        return (lhs.stringValue == rhs.stringValue)
    }
}

extension MACAddress: Hashable {

    public var hashValue: Int {
        return stringValue.hashValue
    }
}


