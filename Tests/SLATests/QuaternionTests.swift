import XCTest
@testable import SLA

final class QuaternionTests: XCTestCase
{
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

    // TODO: testReverseProduct
    // TODO: testAssociativeAddition
    // TODO: testCommutativeAddition
    // TODO: testAssoctiativeProductByScalar
    // TODO: testCommutativeProductByScalar
    // TODO: testDistributiveProductByScalar
    // TODO: testScalarFactorization
    // TODO: testConjugate
    // TODO: testConjugateProduct
    // TODO: testMagnitude
    // TODO: testMagnitudeProduct
    // TODO: testInverse
    // TODO: testProductOfInverses
}
