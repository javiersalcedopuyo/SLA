import XCTest
@testable import SLA

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
        let line :[Float] = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0]

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

    func testRotationMatrixInX()
    {
        let a: Float = 0.123
        let R = Matrix3x3.makeRotation(radians: a, axis: Vector3(x:1, y:0, z:0))

        let reference = Matrix3x3(a: Vector3(x:1, y:0, z:0),
                                  b: Vector3(x:0, y: cos(a), z: sin(a)),
                                  c: Vector3(x:0, y: -sin(a), z: cos(a)))

        XCTAssertEqual(R, reference)
    }

    func testRotationMatrixInY()
    {
        let a: Float = 0.123
        let R = Matrix3x3.makeRotation(radians: a, axis: Vector3(x:0, y:1, z:0))

        let reference = Matrix3x3(a: Vector3(x: cos(a), y:0, z: -sin(a)),
                                  b: Vector3(x: 0, y: 1, z: 0),
                                  c: Vector3(x: sin(a), y: 0, z: cos(a)))

        XCTAssertEqual(R, reference)
    }

    func testRotationMatrixInZ()
    {
        let a: Float = 0.123
        let R = Matrix3x3.makeRotation(radians: a, axis: Vector3(x:0, y:0, z:1))

        let reference = Matrix3x3(a: Vector3(x: cos(a), y: sin(a), z: 0),
                                  b: Vector3(x: -sin(a), y: cos(a), z: 0),
                                  c: Vector3(x: 0, y: 0, z: 1))

        XCTAssertEqual(R, reference)
    }

    func testSetColumn()
    {
        let colIdx = 2
        let newCol = Vector3.identity()

        var A = Matrix3x3.zero()
        A.setColumn(idx: colIdx, val: newCol)

        XCTAssertEqual(A.getColumn(colIdx), newCol)
    }

    func testTransposition()
    {
        let M = Matrix3x3(a: Vector3(x:0, y:1, z:2),
                          b: Vector3(x:3, y:4, z:5),
                          c: Vector3(x:6, y:7, z:8))

        let Mt = M.transposed()

        let cols = M.getDimensions()
        let rows = cols // Square Matrix

        for x in 0..<cols {
            for y in 0..<rows
            {
                XCTAssertEqual(M.get(col: x, row: y), Mt.get(col:y, row:x))
            }
        }
    }

    func testTranspositionOfIdentity()
    {
        let I = Matrix3x3.identity()
        let It = I.transposed()

        XCTAssertEqual(I, It)
    }
}
