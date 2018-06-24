import XCTest
@testable import DataDecoder

class DataDecoderTests: XCTestCase {

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let sensorData: Data = Data([0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5])

            var decoder = DataDecoder(sensorData)

            for _ in sensorData {
                let _ = decoder.decodeUInt8()
            }
        }
    }

    func testNewPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let sensorData: Data = Data([0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5, 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5])

            var tester = DecodeData()

            for _ in sensorData {
                let _ = tester.decodeInt8(sensorData)
            }
        }
    }


    func testSimpleDecodes() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let sensorData: Data = Data([0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5])

        let DEADBEEF: UInt32 = 3735928559

        var decoder = DataDecoder(sensorData)
        let height = decoder.decodeUInt8()
        let weight = decoder.decodeUInt16()
        let beef = decoder.decodeUInt32()
        let nib = decoder.decodeNibble()
        let novalue = decoder.decodeNibble()

        if height != 2 {
            XCTFail()
        }

        if weight != UInt16.max - 1 {
            XCTFail()
        }

        if beef != DEADBEEF {
            XCTFail()
        }

        if nib.lower != 5 && nib.upper != 10 {
            XCTFail()
        }

        if novalue.uint8Value != 0 {
            XCTFail()
        }

    }

    func testSimpleDecodesNew() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let sensorData: Data = Data([0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5])

        let DEADBEEF: UInt32 = 3735928559

        var decoder = DecodeData()
        let height = decoder.decodeUInt8(sensorData)
        let weight = decoder.decodeUInt16(sensorData)
        let beef = decoder.decodeUInt32(sensorData)
        let nib = decoder.decodeNibble(sensorData)
        let novalue = decoder.decodeNibble(sensorData)

        if height != 2 {
            XCTFail()
        }

        if weight != UInt16.max - 1 {
            XCTFail()
        }

        if beef != DEADBEEF {
            XCTFail()
        }

        if nib.lower != 5 && nib.upper != 10 {
            XCTFail()
        }

        if novalue.uint8Value != 0 {
            XCTFail()
        }

    }


    func testUInt24()  {
        let ipData: Data = Data([0xFF, 0xFF, 0xFF])

        var decoder = DataDecoder(ipData)

        let value = decoder.decodeUInt24()

        if value != 0xFFFFFF {
            XCTFail()
        }
    }

    func testUInt24New()  {
        let ipData: Data = Data([0xFF, 0xFF, 0xFF])

        var decoder = DecodeData()

        let value = decoder.decodeUInt24(ipData)

        if value != 0xFFFFFF {
            XCTFail()
        }
    }


    func testUInt48()  {
        let ipData: Data = Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF])

        var decoder = DataDecoder(ipData)

        let value = decoder.decodeUInt48()

        if value != 0xFFFFFFFFFFFF {
            XCTFail()
        }
    }

    func testUInt48New()  {
        let ipData: Data = Data([0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF])

        var decoder = DecodeData()

        let value = decoder.decodeUInt48(ipData)

        if value != 0xFFFFFFFFFFFF {
            XCTFail()
        }
    }


    func testIPAddress()  {
        let ipData: Data = Data([ 0xAD, 0xA5, 0xEE, 0xB2])

        var decoder = DataDecoder(ipData)

        let ipaddress = decoder.decodeIPAddress()

        if ipaddress != "173.165.238.178" {
            XCTFail()
        }
    }

    func testIPAddressNew()  {
        let ipData: Data = Data([ 0xAD, 0xA5, 0xEE, 0xB2])

        var decoder = DecodeData()

        let ipaddress = decoder.decodeIPAddress(ipData)

        if ipaddress != "173.165.238.178" {
            XCTFail()
        }
    }


    func testMACAddress() {
        let ipData: Data = Data([ 0x00, 0x50, 0xC2, 0x34, 0xF7, 0x11])

        var decoder = DataDecoder(ipData)

        let macaddress = decoder.decodeMACAddress()

        if macaddress.stringValue != "00:50:C2:34:F7:11" {
            XCTFail()
        }

    }

    func testMACAddressNew() {
        let ipData: Data = Data([ 0x00, 0x50, 0xC2, 0x34, 0xF7, 0x11])

        var decoder = DecodeData()

        let macaddress = decoder.decodeMACAddress(ipData)

        if macaddress.stringValue != "00:50:C2:34:F7:11" {
            XCTFail()
        }

    }


    static var allTests : [(String, (DataDecoderTests) -> () throws -> Void)] {
        return [
            ("testSimpleDecodes", testSimpleDecodes),
            ("testUInt24", testUInt24),
            ("testUInt48", testUInt48),
            ("testIPAddress", testIPAddress),
            ("testMACADdress", testMACAddress),
        ]
    }
}
