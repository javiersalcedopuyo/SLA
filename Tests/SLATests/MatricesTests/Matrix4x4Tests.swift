import XCTest
@testable import SLA

// As seen on https://docs.microsoft.com/en-gb/windows/win32/direct3d9/d3dxmatrixlookatlh
func DXLookAtRH(eye: Vector3, target: Vector3, upAxis: Vector3) -> Matrix4x4
{
    let zAxis = (target - eye).normalized()
    let xAxis = zAxis.cross(upAxis).normalized()
    let yAxis = xAxis.cross(zAxis)

    let colA = Vector4(xyz: xAxis, w: xAxis.dot(-eye))
    let colB = Vector4(xyz: yAxis, w: yAxis.dot(-eye))
    let colC = Vector4(xyz: zAxis, w: zAxis.dot(-eye))
    let colD = Vector4(x:0, y:0, z:0, w:1)

    return Matrix4x4(a: colA, b: colB, c: colC, d: colD)
}

// As seen on https://docs.microsoft.com/en-gb/windows/win32/direct3d9/d3dxmatrixlookatlh
func DXLookAtLH(eye: Vector3, target: Vector3, upAxis: Vector3) -> Matrix4x4
{
    let zAxis = (target - eye).normalized()
    let xAxis = upAxis.cross(zAxis).normalized()
    let yAxis = zAxis.cross(xAxis)

    let colA = Vector4(xyz: xAxis, w: -xAxis.dot(eye))
    let colB = Vector4(xyz: yAxis, w: -yAxis.dot(eye))
    let colC = Vector4(xyz: zAxis, w: -zAxis.dot(eye))
    let colD = Vector4(x:0, y:0, z:0, w:1)

    return Matrix4x4(a: colA, b: colB, c: colC, d: colD)
}

// As seen on https://docs.microsoft.com/en-gb/windows/win32/direct3d9/d3dxmatrixperspectivefovlh?redirectedfrom=MSDN
func DXPerspectiveLH(fovy:        Float,
                     aspectRatio: Float,
                     near:        Float,
                     far:         Float)
-> Matrix4x4
{
    let yScale = 1.0 / tan(fovy * 0.5)
    let xScale = yScale / aspectRatio

    var result = Matrix4x4.zero()
    result.set(col: 0, row: 0, val: xScale)
    result.set(col: 1, row: 1, val: yScale)
    result.set(col: 2, row: 2, val: far / (far - near))
    result.set(col: 3, row: 2, val: 1.0)
    result.set(col: 2, row: 3, val: -near * far / (far - near))

    return result
}

// As seen on https://docs.microsoft.com/en-gb/windows/win32/direct3d9/d3dxmatrixperspectivefovrh
func DXPerspectiveRH(fovy:        Float,
                     aspectRatio: Float,
                     near:        Float,
                     far:         Float)
-> Matrix4x4
{
    let yScale = 1.0 / tan(fovy * 0.5)
    let xScale = yScale / aspectRatio

    var result = Matrix4x4.zero()
    result.set(col: 0, row: 0, val: xScale)
    result.set(col: 1, row: 1, val: yScale)
    result.set(col: 2, row: 2, val: far / (near - far))
    result.set(col: 3, row: 2, val: -1.0)
    result.set(col: 2, row: 3, val: near * far / (near - far))

    return result
}

final class Matrix4x4Tests: XCTestCase
{
    // NOTE: The following tests are exactly the same as for Matrix3x3, so won't be implemented
    // Equals
    // NotEquals
    // SingleElementAccessor
    // SetSingleElement
    // RotationMatrixInX
    // RotationMatrixInY
    // RotationMatrixInZ
    // TranspositionOfIdentity
    // SetColumn

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

    // Make sure the algorithm is equivalent to DirectX's row-major one
    func testLookAtRH()
    {
        let eye    = Vector3(x:0, y:1, z:2)
        let target = Vector3(x:3, y:4, z:5)
        let up     = Vector3(x:0, y:1, z:0)

        let mine = Matrix4x4.lookAtRH(eye: eye, target: target, upAxis: up)
        let dxs  = DXLookAtRH(eye: eye, target: target, upAxis: up)

        let identityVector = Vector4.identity()

        let myResult = mine * identityVector
        // NOTE: DirectX treats vectors as row matrices, so the multiplication is different
        let dxResult = Vector4(x: identityVector.dot(dxs.getColumn(0)),
                               y: identityVector.dot(dxs.getColumn(1)),
                               z: identityVector.dot(dxs.getColumn(2)),
                               w: identityVector.dot(dxs.getColumn(3)))

        XCTAssertEqual(myResult, dxResult)
    }

    // Make sure the algorithm is equivalent to DirectX's row-major one
    func testLookAtLH()
    {
        let eye    = Vector3(x:0, y:1, z:2)
        let target = Vector3(x:3, y:4, z:5)
        let up     = Vector3(x:0, y:1, z:0)

        let mine = Matrix4x4.lookAtLH(eye: eye, target: target, upAxis: up)
        let dxs  = DXLookAtLH(eye: eye, target: target, upAxis: up)

        let identityVector = Vector4.identity()

        let myResult = mine * identityVector
        // NOTE: DirectX treats vectors as row matrices, so the multiplication is different
        let dxResult = Vector4(x: identityVector.dot(dxs.getColumn(0)),
                               y: identityVector.dot(dxs.getColumn(1)),
                               z: identityVector.dot(dxs.getColumn(2)),
                               w: identityVector.dot(dxs.getColumn(3)))

        XCTAssertEqual(myResult, dxResult)
    }

    func testPerspectiveRH()
    {
        let FOV_Y       = deg2rad(45)
        let AR:   Float = 16/9
        let NEAR: Float = 0.1
        let FAR:  Float = 10

        let point = Vector4(x:4, y:3, z:2, w:1)

        let dxProj  = DXPerspectiveRH(fovy: FOV_Y,
                                      aspectRatio: AR,
                                      near: NEAR,
                                      far: FAR)

        let myProj  = Matrix4x4.perspectiveRH(fovy: FOV_Y,
                                              aspectRatio: AR,
                                              near: NEAR,
                                              far: FAR)

        let refDX   = Vector4(x: point.dot(dxProj.getColumn(0)),
                              y: point.dot(dxProj.getColumn(1)),
                              z: point.dot(dxProj.getColumn(2)),
                              w: point.dot(dxProj.getColumn(3)))

        let mine = myProj * point

        XCTAssertEqual(refDX,  mine)
    }

    func testPerspectiveLH()
    {
        let FOV_Y       = deg2rad(45)
        let AR:   Float = 16/9
        let NEAR: Float = 0.1
        let FAR:  Float = 10

        let point = Vector4(x:4, y:3, z:2, w:1)

        let dxProj  = DXPerspectiveLH(fovy: FOV_Y,
                                      aspectRatio: AR,
                                      near: NEAR,
                                      far: FAR)

        let myProj  = Matrix4x4.perspectiveLH(fovy: FOV_Y,
                                              aspectRatio: AR,
                                              near: NEAR,
                                              far: FAR)

        let refDX   = Vector4(x: point.dot(dxProj.getColumn(0)),
                              y: point.dot(dxProj.getColumn(1)),
                              z: point.dot(dxProj.getColumn(2)),
                              w: point.dot(dxProj.getColumn(3)))

        let mine = myProj * point

        XCTAssertEqual(refDX,  mine)
    }

    func testReversedPerspectiveRH()
    {
        let FOV_Y       = deg2rad(45)
        let AR:   Float = 16/9
        let NEAR: Float = 0.1
        let FAR:  Float = 10

        let point = Vector4(x:4, y:3, z:2, w:1)

        let proj = Matrix4x4.perspectiveRH(fovy: FOV_Y,
                                           aspectRatio: AR,
                                           near: NEAR,
                                           far: FAR)

        let revProj = Matrix4x4.perspectiveReversedRH(fovy: FOV_Y,
                                                      aspectRatio: AR,
                                                      near: NEAR,
                                                      far: FAR)

        let projectedPoint    = proj * point
        let revProjectedPoint = revProj * point

        XCTAssertEqual(projectedPoint.x(), revProjectedPoint.x())
        XCTAssertEqual(projectedPoint.y(), revProjectedPoint.y())

        let zProj1 = projectedPoint.z() / projectedPoint.w()
        let zProj2 = revProjectedPoint.z() / revProjectedPoint.w()

        XCTAssertEqual(zProj1, 1.0 - zProj2, accuracy: 0.0001)
    }

    func testReversedPerspectiveLH()
    {
        let FOV_Y       = deg2rad(45)
        let AR:   Float = 16/9
        let NEAR: Float = 0.1
        let FAR:  Float = 10

        let point = Vector4(x:4, y:3, z:2, w:1)

        let proj = Matrix4x4.perspectiveLH(fovy: FOV_Y,
                                           aspectRatio: AR,
                                           near: NEAR,
                                           far: FAR)

        let revProj = Matrix4x4.perspectiveReversedLH(fovy: FOV_Y,
                                                      aspectRatio: AR,
                                                      near: NEAR,
                                                      far: FAR)

        let projectedPoint    = proj * point
        let revProjectedPoint = revProj * point

        XCTAssertEqual(projectedPoint.x(), revProjectedPoint.x())
        XCTAssertEqual(projectedPoint.y(), revProjectedPoint.y())

        let zProj1 = projectedPoint.z() / projectedPoint.w()
        let zProj2 = revProjectedPoint.z() / revProjectedPoint.w()

        XCTAssertEqual(zProj1, 1.0 - zProj2, accuracy: 0.0001)
    }
}
