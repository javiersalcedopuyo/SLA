public struct Quaternion : Equatable
{
    public init(x: Float, y: Float, z:Float, w: Float)
    {
        self.data = Vector4(x, y, z, w)
    }

    public init(vector: Vector3, scalar: Float)
    {
        self.data = Vector4(xyz: vector, w: scalar)
    }

    static func +(left: Self, right: Self) -> Self
    {
        let resultData = left.data + right.data
        return Self(x: resultData.x,
                    y: resultData.y,
                    z: resultData.z,
                    w: resultData.w)
    }

    static func -(left: Self, right: Self) -> Self
    {
        let resultData = left.data - right.data
        return Self(x: resultData.x,
                    y: resultData.y,
                    z: resultData.z,
                    w: resultData.w)
    }

    static func *(left: Self, right: Self) -> Self
    {
        let v1 = left.getVectorPart()
        let s1 = left.getScalarPart()

        let v2 = right.getVectorPart()
        let s2 = right.getScalarPart()

        let productVector = v1.cross(v2) +
                            s1 * v2 +
                            s2 * v1

        let productScalar = s1 * s2 - v1.dot(v2)

        return Self(vector: productVector, scalar: productScalar)
    }

    public func getVectorPart() -> Vector3  { self.data.xyz() }
    public func getScalarPart() -> Float    { self.data.w }

    private var data: Vector4
}
