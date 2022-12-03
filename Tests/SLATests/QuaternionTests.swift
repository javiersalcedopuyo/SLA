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

    func testProductByConjugateIsAScalar()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let product = q * q.conjugate()

        XCTAssertEqual(product.getVectorPart(), Vector3.zero())
    }

    func testConjugateProduct()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        XCTAssertEqual((q1 * q2).conjugate(),
                       q2.conjugate() * q1.conjugate())
    }

    func testMagnitude()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        XCTAssertEqual(q.magnitude(), sqrt(14))
    }

    func testMagnitudeProduct()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        let m1 = q1.magnitude()
        let m2 = q2.magnitude()

        XCTAssertEqual((q1 * q2).magnitude(),
                       m1 * m2)
    }

    func testMagnitudeProductByPositiveScalar()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let s: Float = 42

        XCTAssertEqual((q * s).magnitude(),
                       s * q.magnitude())
    }

    func testMagnitudeProductByNegativeScalar()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let s: Float = -42

        XCTAssertEqual((q * s).magnitude(),
                       abs(s) * q.magnitude())
    }

    func testIdentity()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let I = Quaternion.identity()

        XCTAssertEqual(I.magnitude(), 1)
        XCTAssertEqual(q * I, q)
    }

    func testIdentityIsCommutable()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let I = Quaternion.identity()

        XCTAssertEqual(q * I, q * I)
    }

    func testInverse()
    {
        let q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let r = q * q.inverse()!

        XCTAssertEqual(r.getVectorPart().x(), 0, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(r.getVectorPart().y(), 0, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(r.getVectorPart().z(), 0, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(r.getScalarPart(),     1, accuracy: FLOAT_EPSILON)
    }

    func testMagnitude0HasNoInverse()
    {
        let q = Quaternion.zero()

        XCTAssertNil(q.inverse())
    }

    func testProductOfInverses()
    {
        let q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        let q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)

        let A = (q1 * q2).inverse()!
        let B = q2.inverse()! * q1.inverse()!

        XCTAssertEqual(A.getVectorPart().x(), B.getVectorPart().x(), accuracy: FLOAT_EPSILON)
        XCTAssertEqual(A.getVectorPart().y(), B.getVectorPart().y(), accuracy: FLOAT_EPSILON)
        XCTAssertEqual(A.getVectorPart().z(), B.getVectorPart().z(), accuracy: FLOAT_EPSILON)
        XCTAssertEqual(A.getScalarPart(),     B.getScalarPart()    , accuracy: FLOAT_EPSILON)
    }

    func testUnitQuaternionInverseIsItsConjugate()
    {
        var q = Quaternion(x: 0, y: 1, z: 2, w: 3)
        q = q / q.magnitude()

        let inv = q.inverse()!
        let con = q.conjugate()

        XCTAssertEqual(inv.getVectorPart().x(), con.getVectorPart().x(), accuracy: FLOAT_EPSILON)
        XCTAssertEqual(inv.getVectorPart().y(), con.getVectorPart().y(), accuracy: FLOAT_EPSILON)
        XCTAssertEqual(inv.getVectorPart().z(), con.getVectorPart().z(), accuracy: FLOAT_EPSILON)
        XCTAssertEqual(inv.getScalarPart(),     con.getScalarPart()    , accuracy: FLOAT_EPSILON)
    }

    func testProductOfUnitQuaternionsIsAUnitQuaternion()
    {
        var q1 = Quaternion(x: 0, y: 1, z: 2, w: 3)
        q1 = q1 / q1.magnitude()

        var q2 = Quaternion(x: 1, y: 2, z: 3, w: 4)
        q2 = q2 / q2.magnitude()

        let q3 = q1 * q2

        XCTAssertEqual(q3.magnitude(), 1, accuracy: FLOAT_EPSILON)
    }

    func testNegatedQuaternionRepresentsTheSameRotation()
    {
        let q = Quaternion.makeRotation(radians: deg2rad(42), axis: Vector3(x: 1, y: 0, z: 0))

        let point = Vector3(x: 0, y: 1, z: 2)

        let p1 = try! rotate(vector: point, quaternion: q)
        let p2 = try! rotate(vector: point, quaternion: -q)

        XCTAssertEqual(p1.x, p2.x, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(p1.y, p2.y, accuracy: FLOAT_EPSILON)
        XCTAssertEqual(p1.z, p2.z, accuracy: FLOAT_EPSILON)
    }

    func test180DegreesRotation()
    {
        let q = Quaternion.makeRotation(radians: PI, axis: Vector3(x: 0, y: 1, z: 0))
        let v = Vector3(x: 1, y: 0, z: 0)

        let v2 = try! rotate(vector: v, quaternion: q)
        XCTAssertEqual(v2.x, -1, accuracy: FLOAT_EPSILON)
    }

    func testRotationAroundItself()
    {
        let p = Vector3(x: 0, y: 1, z: 2)
        let q = Quaternion.makeRotation(radians: deg2rad(42), axis: p)

        let r = try! rotate(vector: p, quaternion: q)

        XCTAssertEqual(r, p)
    }
}
