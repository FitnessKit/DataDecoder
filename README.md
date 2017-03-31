# DataDecoder
Swift Data Decoder.  Easily Decode Data values

## How to Use ##

~~~
  let sensorData: Data = Data([ 0x02, 0xFE, 0xFF, 0xEF, 0xBE, 0xAD, 0xDE, 0xA5])

  var decoder = DataDecoder(sensorData)
  let height = decoder.decodeUInt8()
  let weight = decoder.decodeUInt16()
  let deadbeef = decoder.decodeUInt32()
  let nib = decoder.decodeNibble()
  let novalue = decoder.decodeNibble() //This should come back 0 as there is no more data  left
  ~~~
