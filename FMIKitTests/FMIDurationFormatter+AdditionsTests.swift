import XCTest
@testable import FMIKit

final class FMIDurationFormatter_AdditionsTests: XCTestCase {
  var formatter: DurationFormatter!
  
  override func setUp() {
    super.setUp()
    formatter = DurationFormatter()
  }
  
  func testTimeIntervalFromString() {
    XCTAssertEqual(14_520, formatter.duration(from: "402"))
  }
  
  func testStringFromTimeInterval() {
    XCTAssertEqual("8:00", formatter.string(from: 28_800))
  }
  
  func testEditingStringFromTimeInterval() {
    XCTAssertEqual("801", formatter.editingString(from: 28_860))
  }
}
