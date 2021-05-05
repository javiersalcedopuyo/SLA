import XCTest
import Vectors
@testable import Matrices

final class Matrix3x3Tests: XCTestCase
{
    func testIdentityAndColumnAccessor()
    {
        let I = Matrix3x3.identity()
        XCTAssertEqual( I.getColumn(0), Vector3(x:1, y:0, z:0) )
        XCTAssertEqual( I.getColumn(1), Vector3(x:0, y:1, z:0) )
        XCTAssertEqual( I.getColumn(2), Vector3(x:0, y:0, z:1) )
    }

    func testGetAsSingleArray()
    {
        let line = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]

        let a = Vector3(x:0, y:1, z:2)
        let b = Vector3(x:3, y:4, z:5)
        let c = Vector3(x:6, y:7, z:8)

        let M = Matrix3x3(a:a, b:b, c:c)

        XCTAssertEqual(M.asSingleArray(), line)
    }

    func testMultiplicationByIdentity()
    {
        let a = Vector3(x:0, y:1, z:2)
        let b = Vector3(x:3, y:4, z:5)
        let c = Vector3(x:6, y:7, z:8)

        let M = Matrix3x3(a:a, b:b, c:c)
        let I = Matrix3x3.identity()

        XCTAssertEqual(I*M, M)
        XCTAssertEqual(M*I, M)
    }

    func testMultiplicationOfVectorByIdentity()
    {
        let V = Vector3(x:0, y:1, z:2)
        let I = Matrix3x3.identity()

        XCTAssertEqual(I*V, V)
    }
}
