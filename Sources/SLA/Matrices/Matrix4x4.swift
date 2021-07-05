import Foundation

public struct Matrix4x4 : SquareMatrix
{
    public let size = 4 * 4 * MemoryLayout<Float>.size

    public var contents: [[Float]]
    // (0,0) (1,0) (2,0) (3,0)
    // (0,1) (1,1) (2,1) (3,1)
    // (0,2) (1,2) (2,2) (3,2)
    // (0,3) (1,3) (2,3) (3,3)

    public init(a: Vector4, b: Vector4, c: Vector4, d: Vector4)
    {
        self.contents = [a.contents, b.contents, c.contents, d.contents]
    }

    public static func zero() -> Self
    {
        return Matrix4x4(a: Vector4.zero(),
                         b: Vector4.zero(),
                         c: Vector4.zero(),
                         d: Vector4.zero())
    }

    public static func identity() -> Self
    {
        let a = Vector4(x:1, y:0, z:0, w:0)
        let b = Vector4(x:0, y:1, z:0, w:0)
        let c = Vector4(x:0, y:0, z:1, w:0)
        let d = Vector4(x:0, y:0, z:0, w:1)

        return Matrix4x4(a:a, b:b, c:c, d:d)
    }

    public static func makeRotation(radians: Float, axis: Vector4) -> Self
    {
        let c = cos(radians)
        let s = sin(radians)
        let d = 1.0 - c

        let x  = axis.x() * d
        let y  = axis.y() * d
        let z  = axis.z() * d
        let xy = x * axis.y()
        let xz = x * axis.z()
        let yz = y * axis.z()

        return Matrix4x4 (a: Vector4(x: c  + x * axis.x(),
                                     y: xy + s * axis.z(),
                                     z: xz - s * axis.y(),
                                     w: 0.0),
                          b: Vector4(x: xy - s * axis.z(),
                                     y: c  + y * axis.y(),
                                     z: yz + s * axis.x(),
                                     w: 0.0),
                          c: Vector4(x: xz + s * axis.y(),
                                     y: yz - s * axis.x(),
                                     z: c  + z * axis.z(),
                                     w: 0.0),
                          d: Vector4(x: 0.0,
                                     y: 0.0,
                                     z: 0.0,
                                     w: 1.0))
    }

    public static func lookAtRH(eye: Vector3, target: Vector3, upAxis: Vector3) -> Self
    {
        let zAxis = Vector4( xyz: (target - eye).normalized(), w: 0.0)
        let xAxis = Vector4( xyz: zAxis.xyz().cross(upAxis), w: 0.0).normalized()
        let yAxis = Vector4( xyz: xAxis.xyz().cross(zAxis.xyz()), w: 0.0)

        // Pre-multiply the translation
        let Tx = -xAxis.xyz().dot(eye)
        let Ty = -yAxis.xyz().dot(eye)
        let Tz = -zAxis.xyz().dot(eye)
        let translation = Vector4(x: Tx, y: Ty, z: Tz, w: 1)

        let orientation = Matrix4x4(a: xAxis, b: yAxis, c: zAxis, d: Vector4.zero())

        var lookAt = orientation.transposed()
        lookAt.setColumn(idx: 3, val: translation)

        return lookAt
    }

    public static func lookAtLH(eye: Vector3, target: Vector3, upAxis: Vector3) -> Self
    {
        let zAxis = Vector4( xyz: (target - eye).normalized(), w: 0.0)
        let xAxis = Vector4( xyz: upAxis.cross(zAxis.xyz()), w: 0.0).normalized()
        let yAxis = Vector4( xyz: zAxis.xyz().cross(xAxis.xyz()), w: 0.0)

        // Pre-multiply the translation
        let Tx = -xAxis.xyz().dot(eye)
        let Ty = -yAxis.xyz().dot(eye)
        let Tz = -zAxis.xyz().dot(eye)
        let translation = Vector4(x: Tx, y: Ty, z: Tz, w: 1)

        let orientation = Matrix4x4(a: xAxis, b: yAxis, c: zAxis, d: Vector4.zero())

        var lookAt = orientation.transposed()
        lookAt.setColumn(idx: 3, val: translation)

        return lookAt
    }

    public func getColumn(_ col: Int) -> Vector4
    {
        assert(col <= self.contents.count,    "ERROR: Column \(col) is out of bounds.")
        assert(self.contents[col].count == 4, "ERROR: Column \(col) is not a Vector4!.")

        return Vector4(x: self.contents[col][0],
                       y: self.contents[col][1],
                       z: self.contents[col][2],
                       w: self.contents[col][3])
    }
}
