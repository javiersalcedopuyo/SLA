import Foundation
public struct Matrix3x3 : SquareMatrix
{
    public let dimension = 3
    public let size      = 3 * 3 * MemoryLayout<Float>.size

    // NOTE: Column major
    public var contents: [Float]

    public init(a: Vector3, b: Vector3, c: Vector3)
    {
        self.contents = a.contents + b.contents + c.contents
    }

    public static func zero() -> Self
    {
        return Matrix3x3(a: Vector3.zero(),
                         b: Vector3.zero(),
                         c: Vector3.zero())
    }

    public static func identity() -> Self
    {
        let a = Vector3(x:1, y:0, z:0)
        let b = Vector3(x:0, y:1, z:0)
        let c = Vector3(x:0, y:0, z:1)

        return Matrix3x3(a:a, b:b, c:c)
    }

    public func getColumn(_ col: Int) -> Vector3
    {
        assert(col <= self.dimension, "ERROR: Column \(col) is out of bounds.")

        let i = col * self.dimension

        return Vector3(x: self.contents[i+0],
                       y: self.contents[i+1],
                       z: self.contents[i+2])
    }

    public static func makeRotation(radians: Float, axis: Vector3) -> Self
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

        return Matrix3x3 (a: Vector3(x: c  + x * axis.x(),
                                     y: xy + s * axis.z(),
                                     z: xz - s * axis.y()),
                          b: Vector3(x: xy - s * axis.z(),
                                     y: c  + y * axis.y(),
                                     z: yz + s * axis.x()),
                          c: Vector3(x: xz + s * axis.y(),
                                     y: yz - s * axis.x(),
                                     z: c  + z * axis.z()))
    }

    // TODO: static func *(right: Self, left: Matrix3x4) -> Matrix3x4
}
