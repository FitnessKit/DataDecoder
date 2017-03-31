import XCTest
@testable import DataDecoder

class DataDecoderTests: XCTestCase {

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let sensorData: Data = Data([ 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5])

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


    static var allTests : [(String, (DataDecoderTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
