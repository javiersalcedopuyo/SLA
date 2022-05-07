import Foundation

public struct Matrix3x3 : SquareMatrix
{
    public let dimension = 3
    public let size      = 3 * MemoryLayout<Vector3>.size

    // NOTE: Column major
    public var contents: [Vector3]

    public init(a: Vector3, b: Vector3, c: Vector3)
    {
        self.contents = [a, b, c]
    }

    public static func zero() -> Self
    {
        return Matrix3x3(a: Vector3.zero,
                         b: Vector3.zero,
                         c: Vector3.zero)
    }

    public static func identity() -> Self
    {
        let a = Vector3(x:1, y:0, z:0)
        let b = Vector3(x:0, y:1, z:0)
        let c = Vector3(x:0, y:0, z:1)

        return Matrix3x3(a:a, b:b, c:c)
    }

    public static func makeRotation(radians: Float, axis: Vector3) -> Self
    {
        let c = cos(radians)
        let s = sin(radians)
        let d = 1.0 - c

        let x  = axis.x * d
        let y  = axis.y * d
        let z  = axis.z * d
        let xy = x * axis.y
        let xz = x * axis.z
        let yz = y * axis.z

        return Matrix3x3 (a: Vector3(x: c  + x * axis.x,
                                     y: xy + s * axis.z,
                                     z: xz - s * axis.y),
                          b: Vector3(x: xy - s * axis.z,
                                     y: c  + y * axis.y,
                                     z: yz + s * axis.x),
                          c: Vector3(x: xz + s * axis.y,
                                     y: yz - s * axis.x,
                                     z: c  + z * axis.z))
    }

    // TODO: static func *(right: Self, left: Matrix3x4) -> Matrix3x4

    public func inverse() -> Matrix3x3?
    {
        let determinant = self.determinant()

        if determinant == 0.0
        {
            return nil
        }

        let col0 = self.getColumn(0)
        let col1 = self.getColumn(1)
        let col2 = self.getColumn(2)

        let invDet = 1.0 / determinant

        let row0 = col1.cross(col2) * invDet
        let row1 = col2.cross(col0) * invDet
        let row2 = col0.cross(col1) * invDet

        return Matrix3x3(a: Vector3(x: row0.x(), y: row1.x(), z: row2.x()),
                         b: Vector3(x: row0.y(), y: row1.y(), z: row2.y()),
                         c: Vector3(x: row0.z(), y: row1.z(), z: row2.z()))
    }

    public func determinant() -> Float
    {
        let a = self.getColumn(0)
        let b = self.getColumn(1)
        let c = self.getColumn(2)

        return (a.cross(b)).dot(c)
    }
}
