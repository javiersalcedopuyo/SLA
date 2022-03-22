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

    func testComparingEqualFloats()
    {
        let a: Float = 0.123456
        let b: Float = 0.123456

        XCTAssertTrue( areAlmostEqual(a, b) )
    }

    func testComparingConstantFloatWithOperationResult()
    {
        let a: Float = 0.123456
        let b: Float = 0.123457

        XCTAssertTrue( areAlmostEqual(a, b) )
    }
}