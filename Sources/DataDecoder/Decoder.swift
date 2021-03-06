//
//  Decoder.swift
//  DataDecoder
//
//  Created by Kevin Hoogheem on 6/23/18.
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

internal enum DecoderSFloatValues: Int16 {
    case positiveInfinity       = 0x07FE
    case nan                    = 0x07FF
    case res                    = 0x0800
    case reservedvalue          = 0x0801
    case negativeInfinity       = 0x0802
}

internal enum DecoderFloatValues: UInt32 {
    case positiveInfinity       = 0x007FFFFE
    case nan                    = 0x007FFFFF
    case res                    = 0x00800000
    case reservedvalue          = 0x00800001
    case negativeInfinity       = 0x00800002
}

/// Decoder
///
/// Provides easy methods for Decoding values out of a Data Stream
public struct DecodeData {
    private lazy var kReservedFloatValues: [Double] = {
        return [Double.infinity, Double.nan, Double.nan, Double.nan, -Double.infinity]
    }()

    /// Current Index
    ///
    /// The index into the data the decoder is at
    private(set) public var index: Int = 0

    public init(startIndex: Int = 0) {
        self.index = startIndex
    }

}

public extension DecodeData {

    /// Decodes Raw data from data Stream
    ///
    /// - Parameters:
    ///   - data: Data stream
    ///   - length: Length of Data to pull out of stream
    /// - Returns: Data Instance
    mutating func decodeData(_ data: Data, length: Int) -> Data {
        return decodeDataIfPresent(data, length: length) ?? Data()
    }

    /// Decodes Raw data from data Stream only if Present
    ///
    /// - Parameter data: Data stream
    /// - Parameter length: Length of Data to pull out of stream
    /// - Returns: Data Instance
    mutating func decodeDataIfPresent(_ data: Data, length: Int) -> Data? {
        var value: [UInt8] = [UInt8]()

        if index + length > data.count {
            return nil
        }
        
        for _ in index..<(index + length) {
            value.append(data.scanValue(index: &index, type: UInt8.self) ?? 0)
        }

        return Data(value)
    }

    /// Decodes Nibble from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Nibble Instance
    mutating func decodeNibble(_ data: Data) -> Nibble {
        let value = decodeNibbleIfPresent(data) ?? Nibble(0)
        return value
    }

    /// Decodes Nibble from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: Nibble value
    mutating func decodeNibbleIfPresent(_ data: Data) -> Nibble? {
        let value = data.scanValue(index: &index, type: UInt8.self)

        if let value = value  {
            return Nibble(value)
        }

        return nil
    }

    /// Decodes Int8 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int8 value
    mutating func decodeInt8(_ data: Data) -> Int8 {
        return decodeInt8IfPresent(data) ?? 0
    }

    /// Decodes Int8 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt8 value
    mutating func decodeInt8IfPresent(_ data: Data) -> Int8? {
        return data.scanValue(index: &index, type: Int8.self)
    }

    /// Decodes UInt8 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt8 value
    mutating func decodeUInt8(_ data: Data) -> UInt8 {
        return decodeUInt8IfPresent(data) ?? 0
    }

    /// Decodes UInt8 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt8 value
    mutating func decodeUInt8IfPresent(_ data: Data) -> UInt8? {
        return data.scanValue(index: &index, type: UInt8.self)
    }

    /// Decodes Int16 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int16 value
    mutating func decodeInt16(_ data: Data) -> Int16 {
        return decodeInt16IfPresent(data) ?? 0
    }

    /// Decodes Int16 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int16 value
    mutating func decodeInt16IfPresent(_ data: Data) -> Int16? {
        return data.scanValue(index: &index, type: Int16.self)
    }

    /// Deocdes UInt16 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt16 value
    mutating func decodeUInt16(_ data: Data) -> UInt16 {
        return decodeUInt16IfPresent(data) ?? 0
    }

    /// Decodes UInt16 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt16 value
    mutating func decodeUInt16IfPresent(_ data: Data) -> UInt16? {
        return data.scanValue(index: &index, type: UInt16.self)
    }

    /// Decodes UInt24 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int value
    mutating func decodeUInt24(_ data: Data) -> Int {
        let val0 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val1 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val2 = data.scanValue(index: &index, type: UInt8.self) ?? 0

        let value: Int = Int( (Int(val2) << 16) | (Int(val1) <<  8) | Int(val0))
        return Int(value)
    }

    /// Decodes Int24 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int value
    mutating func decodeInt24(_ data: Data) -> Int {
        let val0 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val1 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val2 = data.scanValue(index: &index, type: UInt8.self) ?? 0

        var value: Int = 0

        if val2 & 0x80 == 1 {

            value |= Int(val0)
            value |= Int(val1) <<  8
            value |= Int(val2) << 16
            value |= Int(0xFF) << 24

        } else {
            value = Int( (Int(val2) << 16) | (Int(val1) <<  8) | Int(val0) )
        }

        return value
    }

    /// Decodes Int32 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int32 value
    mutating func decodeInt32(_ data: Data) -> Int32 {
        return decodeInt32IfPresent(data) ?? 0
    }

    /// Decodes Int32 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int32 value
    mutating func decodeInt32IfPresent(_ data: Data) -> Int32? {
        return data.scanValue(index: &index, type: Int32.self)
    }

    /// Decodes UInt32 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt32 value
    mutating func decodeUInt32(_ data: Data) -> UInt32 {
        return decodeUInt32IfPresent(data) ?? 0
    }

    /// Decodes UInt32 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt32 value
    mutating func decodeUInt32IfPresent(_ data: Data) -> UInt32? {
        return data.scanValue(index: &index, type: UInt32.self)
    }

    /// Decodes UInt48 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt value
    mutating func decodeUInt48(_ data: Data) -> UInt {
        let val0 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val1 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val2 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val3 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val4 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val5 = data.scanValue(index: &index, type: UInt8.self) ?? 0

        var value: UInt = 0

        value |= UInt(val0)
        value |= UInt(val1) <<  8
        value |= UInt(val2) << 16
        value |= UInt(val3) << 24
        value |= UInt(val4) << 32
        value |= UInt(val5) << 40

        return value
    }

    /// Deocdes Int64 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int64 value
    mutating func decodeInt64(_ data: Data) -> Int64 {
        return decodeInt64IfPresent(data) ?? 0
    }

    /// Decodes Int64 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: Int64 value
    mutating func decodeInt64IfPresent(_ data: Data) -> Int64? {
        return data.scanValue(index: &index, type: Int64.self)
    }

    /// Decodes UInt64 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt64 value
    mutating func decodeUInt64(_ data: Data) -> UInt64 {
        return decodeUInt64IfPresent(data) ?? 0
    }

    /// Decodes UInt64 from the data stream only if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: UInt64 value
    mutating func decodeUInt64IfPresent(_ data: Data) -> UInt64? {
        return data.scanValue(index: &index, type: UInt64.self)
    }

}

//MARK: - Other Decodes
public extension DecodeData {

    /// Decodes IP Address from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Parameter fromLittleEndian: If IP Address is encoded as Little Endian
    /// - Returns: String Representation of the IP Address
    mutating func decodeIPAddress(_ data: Data, fromLittleEndian: Bool = false) -> String {
        let val0 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val1 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val2 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val3 = data.scanValue(index: &index, type: UInt8.self) ?? 0

        var retVal = "0.0.0.0"

        if fromLittleEndian == true {
            retVal = String(format: "%d.%d.%d.%d", val3, val2, val1, val0)
        } else {
            retVal = String(format: "%d.%d.%d.%d", val0, val1, val2, val3)
        }

        return retVal
    }

    /// Decodes MAC Address from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Parameter fromLittleEndian: If MAC is encoded as Little Endian
    /// - Returns: String Representation of the MAC Address
    mutating func decodeMACAddress(_ data: Data, fromLittleEndian: Bool = false) -> MACAddress {
        let val0 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val1 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val2 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val3 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val4 = data.scanValue(index: &index, type: UInt8.self) ?? 0
        let val5 = data.scanValue(index: &index, type: UInt8.self) ?? 0

        var retVal = "00:00:00:00:00:00"

        if fromLittleEndian == true {
            retVal = String(format: "%02X:%02X:%02X:%02X:%02X:%02X", val5, val4, val3, val2, val1, val0)
        } else {
            retVal = String(format: "%02X:%02X:%02X:%02X:%02X:%02X", val0, val1, val2, val3, val4, val5)
        }

        return MACAddress(string: retVal)
    }

}

//MARK: - ANT Decodes
public extension DecodeData {

    /// Decodes ANT Toggle Byte from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: ANTToggleByte Instance
    mutating func decodeANTToggleByte(_ data: Data) -> ANTToggleByte {
        let value = data.scanValue(index: &index, type: UInt8.self) ?? 0
        return ANTToggleByte(value)
    }

}

//MARK: - IEEE-754 Decodes
public extension DecodeData {

    /// Decodes IEEE-754 Float32 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float32 Value
    mutating func decodeFloat32(_ data: Data) -> Float32 {
        return decodeFloat32IfPresent(data) ?? 0.0
    }

    /// Decodes IEEE-754 Float32 from the data stream if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float32 Value
    mutating func decodeFloat32IfPresent(_ data: Data) -> Float32? {
        return data.scanValue(index: &index, type: Float32.self)
    }

    /// Decodes IEEE-754 Float64 from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float64 Value
    mutating func decodeFloat64(_ data: Data) -> Float64 {
        return decodeFloat64IfPresent(data) ?? 0.0
    }

    /// Decodes IEEE-754 Float64 from the data stream if present
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float64 Value
    mutating func decodeFloat64IfPresent(_ data: Data) -> Float64? {
        return data.scanValue(index: &index, type: Float64.self)
    }

}

//MARK: - IEEE-11073 Decodes
public extension DecodeData {

    /// Decodes IEEE-11073 16-bit SFLOAT from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float value
    mutating func decodeSFloatValue(_ data: Data) -> Float {
        return decodeSFloatValueIfPresent(data) ?? 0
    }

    /// Decodes IEEE-11073 16-bit SFLOAT from the data stream only if Present
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float value
    mutating func decodeSFloatValueIfPresent(_ data: Data) -> Float? {
        if let tmpValue = data.scanValue(index: &index, type: Int16.self)  {
            var mantissa = Int16(tmpValue & 0x0FFF)
            var exponent = Int8(tmpValue >> 12)

            if exponent >= 0x0008 {
                exponent = -((0x000F + 1) - exponent)
            }

            var returnResult: Float = 0

            if mantissa >= DecoderSFloatValues.positiveInfinity.rawValue &&
                mantissa <= DecoderSFloatValues.negativeInfinity.rawValue {
                let index: Int = Int(mantissa - DecoderSFloatValues.positiveInfinity.rawValue)
                returnResult = Float(kReservedFloatValues[index])
            } else {

                if mantissa > 0x0800 {
                    mantissa = -((0x0FFF + 1) - mantissa)
                }

                let magnitude = pow(10.0, Double(exponent))
                returnResult = Float(mantissa) * Float(magnitude)
            }

            return returnResult
        }

        return nil
    }

    /// Decodes IEEE-11073 32-bit FLOAT from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float value
    mutating func decodeFloatValue(_ data: Data) -> Float {
        return decodeFloatValueifPresent(data) ?? 0
    }

    /// Decodes IEEE-11073 32-bit FLOAT from the data stream
    ///
    /// - Parameter data: Data stream
    /// - Returns: Float value
    mutating func decodeFloatValueifPresent(_ data: Data) -> Float? {
        if let tmpValue = data.scanValue(index: &index, type: Int32.self) {
            var mantissa = Int32(tmpValue & 0x00FFFFFF)
            let exponent = Int8(tmpValue >> 24)

            var returnResult: Float = 0

            if mantissa >= Int32(DecoderFloatValues.positiveInfinity.rawValue) && mantissa <= Int32(DecoderFloatValues.negativeInfinity.rawValue) {
                let index: Int = Int(mantissa - Int32(DecoderFloatValues.positiveInfinity.rawValue))
                returnResult = Float(kReservedFloatValues[index])
            } else {

                if mantissa >= 0x800000 {
                    mantissa = -((0xFFFFFF + 1) - mantissa)
                }

                let magnitude = pow(10.0, Double(exponent))
                returnResult = Float(mantissa) * Float(magnitude)
            }

            return returnResult
        }

        return nil
    }
}
