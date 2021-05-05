import XCTest
@testable import SLA

final class SLATests: XCTestCase
{
    func testDeg2Rad()
    {
        XCTAssertEqual(deg2rad(180.0), TAU * 0.5)
    }
    func testRad2Deg()
    {
        XCTAssertEqual(rad2deg(TAU * 0.5), 180.0)
    }
}