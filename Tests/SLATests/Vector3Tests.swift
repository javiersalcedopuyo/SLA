import XCTest
@testable import SLA

final class Vector3Tests: XCTestCase
{
    func testLerpNegativeT()
    {
        let a = Vector3.zero()
        let b = Vector3.identity()

        XCTAssertEqual( Vector3.lerp(from: a, to: b, t: -1.0), a )
    }

    func testLerpT0()
    {
        let a = Vector3.zero()
        let b = Vector3.identity()

        XCTAssertEqual( Vector3.lerp(from: a, to: b, t: 0.0), a )
    }

    func testLerpT0_5()
    {
        let a = Vector3.zero()
        let b = Vector3.identity()

        XCTAssertEqual( Vector3.lerp(from: a, to: b, t: 0.5), b * 0.5 )
    }

    func testLerpT1()
    {
        let a = Vector3.zero()
        let b = Vector3.identity()

        XCTAssertEqual( Vector3.lerp(from: a, to: b, t: 1.0), b )
    }

    func testLerpTGreaterThan1()
    {
        let a = Vector3.zero()
        let b = Vector3.identity()

        XCTAssertEqual( Vector3.lerp(from: a, to: b, t: 1.5), b )
    }

    func testOrthogonalDotProduct()
    {
        let a = Vector3( x:2.0, y:0.0, z:0.0 )
        let b = Vector3( x:0.0, y:3.0, z:0.0 )

        XCTAssertEqual( a.dot(b), 0.0 )
    }

    func testParallelDotProduct()
    {
        let a = Vector3( x:1.0, y:2.0, z:3.0 )
        let b = Vector3( x:2.0, y:4.0, z:6.0 )

        let normsProduct = a.norm() * b.norm()

        XCTAssertEqual( a.dot(b), normsProduct, accuracy: 0.0001)
    }

    func testCrossProduct()
    {
        let x = Vector3( x:1.0, y:0.0, z:0.0 )
        let y = Vector3( x:0.0, y:1.0, z:0.0 )
        let z = Vector3( x:0.0, y:0.0, z:1.0 )

        XCTAssertEqual( x.cross(y), z )
    }

    func testInverseCrossProduct()
    {
        let x = Vector3( x:1.0, y:0.0, z:0.0 )
        let y = Vector3( x:0.0, y:1.0, z:0.0 )
        let z = Vector3( x:0.0, y:0.0, z:1.0 )

        XCTAssertEqual( y.cross(x), -z )
    }

    func testNormalized()
    {
        let a = Vector3( x:1.0, y:2.0, z:3.0 )
        let n = a.normalized()

        XCTAssertEqual( n.norm2(), 1.0, accuracy: 0.0001 )
        XCTAssertEqual( n.norm(),  1.0, accuracy: 0.0001 )
    }

    func testNormalizedZero()
    {
        XCTAssertEqual(Vector3.zero().normalized(), Vector3.zero())
    }
}