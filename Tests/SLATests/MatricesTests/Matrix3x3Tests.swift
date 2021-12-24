import XCTest
@testable import SLA

final class Matrix3x3Tests: XCTestCase
{
    func testEquals()
    {
        let A = Matrix3x3.identity()
        let B = Matrix3x3.identity()

        XCTAssertEqual(A, B)
    }

    func testNotEquals()
    {
        let A = Matrix3x3.identity()
        let B = Matrix3x3.zero()

        XCTAssertNotEqual(A, B)
    }

    func testSingleElementAccessor()
    {
        let I = Matrix3x3.identity()

        XCTAssertEqual(I.get(col: 0, row: 0), 1.0)
        XCTAssertEqual(I.get(col: 1, row: 0), 0.0)
    }

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

    func testSetSingleElement()
    {
        let X = 0
        let Y = 0
        let val: Float = 2.0

        var A = Matrix3x3.identity()

        A.set(col: X, row: Y, val: val)

        XCTAssertEqual(A.get(col: X, row: Y), val)
    }

    func testTransposition()
    {
        let M = Matrix3x3(a: Vector3(x:0, y:1, z:2),
                          b: Vector3(x:3, y:4, z:5),
                          c: Vector3(x:6, y:7, z:8))

        let Mt = M.transposed()

        for x in 0..<M.dimension {
            for y in 0..<M.dimension
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

    func testScalingIdentity()
    {
        let scale     = Vector3(x: 1, y: 2, z: 3)
        let reference = Matrix3x3.makeScale(scalePerAxis: scale)
        let I         = Matrix3x3.identity()

        XCTAssertEqual(I.scaled(scalePerAxis: scale), reference)
    }

    func testMultAssignByScalar()
    {
        let scalar: Float = 10.0
        var M = Matrix3x3.identity()
        M *= scalar

        for i in 0..<M.dimension
        {
            XCTAssertEqual(M.get(col: i, row: i), scalar)
        }
    }

    func testMultByScalar()
    {
        let scalar: Float = 10.0
        let M = Matrix3x3.identity() * scalar

        for i in 0..<M.dimension
        {
            XCTAssertEqual(M.get(col: i, row: i), scalar)
        }
    }

    func testDivideAssignByScalar()
    {
        var M = Matrix3x3.identity()
        M /= 2.0

        for i in 0..<M.dimension
        {
            XCTAssertEqual(M.get(col:i, row:i), 0.5)
        }
    }

    func testDivideByScalar()
    {
        let I = Matrix3x3.identity()
        let M = I / 2.0

        for i in 0..<M.dimension
        {
            XCTAssertEqual(M.get(col:i, row:i), 0.5)
        }
    }
}
