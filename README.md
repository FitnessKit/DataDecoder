# DataDecoder
Swift Data Decoder.  Easily Decode Data values

[![Swift4](https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat)](https://developer.apple.com/swift)
[![CI Status](http://img.shields.io/travis/FitnessKit/DataDecoder.svg?style=flat)](https://travis-ci.org/FitnessKit/DataDecoder)
[![Version](https://img.shields.io/cocoapods/v/DataDecoder.svg?style=flat)](http://cocoapods.org/pods/DataDecoder)
[![License](https://img.shields.io/cocoapods/l/DataDecoder.svg?style=flat)](http://cocoapods.org/pods/DataDecoder)
[![Platform](https://img.shields.io/cocoapods/p/DataDecoder.svg?style=flat)](http://cocoapods.org/pods/DataDecoder)

## Installation

DataDecoder is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "DataDecoder"
```

Swift Package Manager:

Swift3
```swift
    dependencies: [
        .Package(url: "https://github.com/FitnessKit/DataDecoder", majorVersion: 0)
    ]
```
Swift4
```swift
    dependencies: [
        .package(url: "https://github.com/FitnessKit/DataDecoder", from: "4.1.0"),
    ]
```

## How to Use ##

~~~
  let sensorData: Data = Data([ 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5])

  var decoder = DecodeData()
  let height = decoder.decodeUInt8(sensorData)
  let weight = decoder.decodeUInt16(sensorData)
  let deadbeef = decoder.decodeUInt32(sensorData)
  let nib = decoder.decodeNibble(sensorData)
  let novalue = decoder.decodeNibble(sensorData) //This should come back 0 as there is no more data left
  ~~~

## Data Decoders ##

* Nibble
* UInt8/Int8
* UInt16/Int16
* UInt24/Int23
* UInt32/Int32
* UInt48
* UInt64/Int64
* IEEE-11073 16-bit SFLOAT
* IEEE-11073 32-bit FLOAT
* IP Address to String Value
* MAC Address to String Value

## Author

This package is developed and maintained by Kevin A. Hoogheem

## License

DataDecoder is available under the [MIT license](http://opensource.org/licenses/MIT)
