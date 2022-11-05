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

    func testQuaternionRotation()
    {
        let point = Vector3(x: 0, y: 1, z: 2)
        let axis  = Vector3(x: 0, y: 1, z: 2).normalized()
        let angle = deg2rad(42)

        let M = Matrix3x3.makeRotation(radians: angle, axis: axis)
        let Q = Quaternion.makeRotation(radians: angle, axis: axis)

        let p1 = M * point
        let p2 = try! rotate(vector: point, quaternion: Q)

        XCTAssertEqual(p1.x, p2.x, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(p1.y, p2.y, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(p1.z, p2.z, accuracy: FLOAT_EPSILON)
    }

    func testQuaternionToRotationMatrix()
    {
        let point = Vector3(x: 0, y: 1, z: 2)
        let axis  = Vector3(x: 0, y: 1, z: 2).normalized()
        let angle = deg2rad(42)

        let Q = Quaternion.makeRotation(radians: angle, axis: axis)
        let M1 = Matrix3x3.makeRotation(radians: angle, axis: axis)
        let M2 = makeRotationMatrixFrom(quaternion: Q)

        let p1 = M1 * point
        let p2 = M2 * point

        XCTAssertEqual(p1.x, p2.x, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(p1.y, p2.y, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(p1.z, p2.z, accuracy: FLOAT_EPSILON)
    }

    // TODO: func testRotationMatrixToQuaternion()
}