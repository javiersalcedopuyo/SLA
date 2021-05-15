public struct Matrix3x3 : SquareMatrix
{
    public var contents: [[Double]]
    // (0,0) (1,0) (2,0)
    // (0,1) (1,1) (2,1)
    // (0,2) (1,2) (2,2)

    public init(a: Vector3, b: Vector3, c: Vector3)
    {
        self.contents = [a.contents, b.contents, c.contents]
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
        assert(col <= self.contents.count,    "ERROR: Column \(col) is out of bounds.")
        assert(self.contents[col].count == 3, "ERROR: Column \(col) is not a Vector3!.")

        return Vector3(x: self.contents[col][0],
                       y: self.contents[col][1],
                       z: self.contents[col][2])
    }

    // TODO: static func *(right: Self, left: Matrix3x4) -> Matrix3x4
}
