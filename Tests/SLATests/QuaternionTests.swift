import XCTest
@testable import SLA

final class QuaternionTests: XCTestCase
{
    // MARK: - Test Basic Math Properties
    func testAddition()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)
        let result = Quaternion(x: 1, y: 3, z: 5, w: 7)

        XCTAssertEqual(q1 + q2, result)
    }

    func testSubstraction()
    {
        let q1 = Quaternion(x: 1, y: 2, z: 3, w: 4)
        let q2 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let result = Quaternion(x: 1, y: 1, z: 1, w: 1)

        XCTAssertEqual(q1 - q2, result)
    }

    func testProduct()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)
        let result = Quaternion(x: 2, y: 12, z: 16, w: 4)

        XCTAssertEqual(q1 * q2, result)
    }

    func testNoCommutativeProduct()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        XCTAssertNotEqual(q1 * q2, q2 * q1)
    }

    func testReverseProduct()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        let v1 = q1.getVectorPart()
        let v2 = q2.getVectorPart()

        XCTAssertEqual(q2 * q1,
                       q1 * q2 - 2 * v1.cross(v2))
    }

    func testAssociativeAddition()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)
        let q3 = Quaternion(x: 2, y: 3, z: 4, w: 5)

        XCTAssertEqual((q1 + q2) + q3,
                        q1 + (q2 + q3))
    }

    func testCommutativeAddition()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        XCTAssertEqual(q1 + q2, q2 + q1)
    }

    func testAssoctiativeProductByScalar()
    {
        let s: Float = 42.0
        let t: Float = 12.0
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)

        XCTAssertEqual((s * t) * q,
                       s * (t * q))
    }

    func testCommutativeProductByScalar()
    {
        let t: Float = 42.0
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)

        XCTAssertEqual(t * q, q * t)
    }

    func testDistributiveProductSumByScalar()
    {
        let t: Float = 42.0
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        XCTAssertEqual(t * (q1 + q2),
                       t * q1 + t * q2)
    }

    func testDistributiveProductBySumOfScalars()
    {
        let s: Float = 42.0
        let t: Float = 12.0
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)

        XCTAssertEqual((s + t) * q,
                       s * q + t * q)
    }

    func testScalarFactorization()
    {
        let t: Float = 42.0
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        XCTAssertEqual((t * q1) * q2,
                       q1 * (t * q2))

        XCTAssertEqual(q1 * (t * q2),
                       t * (q1 * q2))
    }

    func testConjugate()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let c = q.conjugate()

        XCTAssertEqual(q.getVectorPart(), -c.getVectorPart())
        XCTAssertEqual(q.getScalarPart(),  c.getScalarPart())
    }

    func testConjugateProduct()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        XCTAssertEqual((q1 * q2).conjugate(),
                       q2.conjugate() * q1.conjugate())
    }

    // TODO: testMagnitude
    // TODO: testMagnitudeProduct
    // TODO: testInverse
    // TODO: testProductOfInverses
}
