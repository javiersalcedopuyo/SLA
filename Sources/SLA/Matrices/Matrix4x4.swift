public struct Matrix4x4 : SquareMatrix
{
    public var contents: [[Double]]
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
