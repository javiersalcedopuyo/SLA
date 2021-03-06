import XCTest
@testable import SLA

final class Vector4Tests: XCTestCase
{
    func testLerpNegativeT()
    {
        let a = Vector4.zero()
        let b = Vector4.identity()

        XCTAssertEqual( lerp(from: a, to: b, t: -1.0), a )
    }

    func testLerpT0()
    {
        let a = Vector4.zero()
        let b = Vector4.identity()

        XCTAssertEqual( lerp(from: a, to: b, t: 0.0), a )
    }

    func testLerpT0_5()
    {
        let a = Vector4.zero()
        let b = Vector4.identity()

        XCTAssertEqual( lerp(from: a, to: b, t: 0.5), b * 0.5 )
    }

    func testLerpT1()
    {
        let a = Vector4.zero()
        let b = Vector4.identity()

        XCTAssertEqual( lerp(from: a, to: b, t: 1.0), b )
    }

    func testLerpTGreaterThan1()
    {
        let a = Vector4.zero()
        let b = Vector4.identity()

        XCTAssertEqual( lerp(from: a, to: b, t: 1.5), b )
    }

    func testOrthogonalDotProduct()
    {
        let a = Vector4( x:2.0, y:0.0, z:0.0, w: 0.0 )
        let b = Vector4( x:0.0, y:3.0, z:0.0, w: 0.0 )

        XCTAssertEqual( a.dot(b), 0.0, accuracy: 0.0001)
    }

    func testParallelDotProduct()
    {
        let a = Vector4( x:1.0, y:2.0, z:3.0, w: 4.0)
        let b = Vector4( x:2.0, y:4.0, z:6.0, w: 8.0)

        let normsProduct = a.norm() * b.norm()

        XCTAssertEqual( a.dot(b), normsProduct, accuracy: 0.0001 )
    }

    func testNormalized()
    {
        let a = Vector4( x:1.0, y:2.0, z:3.0, w: 4.0 )
        let n = a.normalized()

        XCTAssertEqual( n.norm2(), 1.0, accuracy: 0.0001)
        XCTAssertEqual( n.norm(),  1.0, accuracy: 0.0001)
    }

    func testNormalizedZero()
    {
        XCTAssertEqual(Vector4.zero().normalized(), Vector4.zero())
    }

    func testGetAsPackedArray()
    {
        let a :[Float] = [0.0,  1.0,  2.0, 3.0]
        let v = Vector4(x:0, y:1, z:2, w:3)

        XCTAssertEqual(v.asPackedArray(), a)
    }

    func testSizeInBytes()
    {
        XCTAssertEqual(MemoryLayout<Vector3>.size, MemoryLayout<Float>.size * 4)
    }
}
