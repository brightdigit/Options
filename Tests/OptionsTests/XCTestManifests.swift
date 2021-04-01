#if !canImport(ObjectiveC)
  import XCTest

  extension EnumSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EnumSetTests = [
      ("testArray", testArray),
      ("testDecoder", testDecoder),
      ("testEncoder", testEncoder),
      ("testInitValue", testInitValue),
      ("testInitValues", testInitValues)
    ]
  }

  extension MappedEnumTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MappedEnumTests = [
      ("testDecoder", testDecoder),
      ("testEncoder", testEncoder)
    ]
  }

  extension MappedValueCollectionRepresentedTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MappedValueCollectionRepresentedTests = [
      ("testRawValue", testRawValue),
      ("testRawValueFailure", testRawValueFailure),
      ("testString", testString),
      ("testStringFailure", testStringFailure)
    ]
  }

  extension MappedValueRepresentableTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__MappedValueRepresentableTests = [
      ("testStringValue", testStringValue)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    return [
      testCase(EnumSetTests.__allTests__EnumSetTests),
      testCase(MappedEnumTests.__allTests__MappedEnumTests),
      testCase(MappedValueCollectionRepresentedTests.__allTests__MappedValueCollectionRepresentedTests),
      testCase(MappedValueRepresentableTests.__allTests__MappedValueRepresentableTests)
    ]
  }
#endif
