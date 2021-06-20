import XCTest
@testable import SLA

final class Matrix4x4Tests: XCTestCase
{
    func testIdentityAndColumnAccessor()
    {
        let I = Matrix4x4.identity()
        XCTAssertEqual( I.getColumn(0), Vector4(x:1, y:0, z:0, w:0) )
        XCTAssertEqual( I.getColumn(1), Vector4(x:0, y:1, z:0, w:0) )
        XCTAssertEqual( I.getColumn(2), Vector4(x:0, y:0, z:1, w:0) )
        XCTAssertEqual( I.getColumn(3), Vector4(x:0, y:0, z:0, w:1) )
    }

    func testGetAsSingleArray()
    {
        let line :[Float] = [0.0,  1.0,  2.0,  3.0,
                             4.0,  5.0,  6.0,  7.0,
                             8.0,  9.0,  10.0, 11.0,
                             12.0, 13.0, 14.0, 15.0]

        let a = Vector4(x:0,  y:1,  z:2,  w: 3)
        let b = Vector4(x:4,  y:5,  z:6,  w: 7)
        let c = Vector4(x:8,  y:9,  z:10, w: 11)
        let d = Vector4(x:12, y:13, z:14, w: 15)

        let M = Matrix4x4(a:a, b:b, c:c, d:d)

        XCTAssertEqual(M.asSingleArray(), line)
    }

    func testMultiplicationByIdentity()
    {
        let a = Vector4(x:0,  y:1,  z:2,  w: 3)
        let b = Vector4(x:4,  y:5,  z:6,  w: 7)
        let c = Vector4(x:8,  y:9,  z:10, w: 11)
        let d = Vector4(x:12, y:13, z:14, w: 15)

        let M = Matrix4x4(a:a, b:b, c:c, d:d)
        let I = Matrix4x4.identity()

        XCTAssertEqual(I*M, M)
        XCTAssertEqual(M*I, M)
    }

    func testMultiplicationOfVectorByIdentity()
    {
        let V = Vector4(x:0, y:1, z:2, w:3)
        let I = Matrix4x4.identity()

        XCTAssertEqual(I*V, V)
    }

    // NOTE: The following tests are exactly the same as for Matrix3x3, so won't be implemented
    // func testRotationMatrixInX()
    // func testRotationMatrixInY()
    // func testRotationMatrixInZ()
}
