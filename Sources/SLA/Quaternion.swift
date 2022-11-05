import Foundation

enum QuaternionErrors : Error
{
    case NoInverse
}

public struct Quaternion : Equatable
{
    // MARK: - Public
    public init(x: Float, y: Float, z:Float, w: Float) { self.data = Vector4(x, y, z, w) }

    public init(vector: Vector3, scalar: Float) { self.data = Vector4(xyz: vector, w: scalar) }

    public static func zero()       -> Self { Self(vector: Vector3.zero(), scalar: 0) }
    public static func identity()   -> Self { Self(vector: Vector3.zero(), scalar: 1) }

    public static func makeRotation(radians: Float, axis: Vector3) -> Self
    {
        let halfRadians = radians * 0.5
        let v = sin(halfRadians) * axis
        let s = cos(halfRadians)

        return Self(vector: v, scalar: s)
    }

    public static prefix func -(right: Self) -> Self
    {
        Self(vector: -right.getVectorPart(), scalar: -right.getScalarPart())
    }

    public static func +(left: Self, right: Self) -> Self
    {
        let resultData = left.data + right.data
        return Self(x: resultData.x,
                    y: resultData.y,
                    z: resultData.z,
                    w: resultData.w)
    }

    public static func +(left: Self, right: Vector3) -> Self
    {
        return Self(vector: left.getVectorPart() + right,
                    scalar: left.getScalarPart())
    }

    public static func -(left: Self, right: Self) -> Self
    {
        let resultData = left.data - right.data
        return Self(x: resultData.x,
                    y: resultData.y,
                    z: resultData.z,
                    w: resultData.w)
    }

    public static func -(left: Self, right: Vector3) -> Self
    {
        return Self(vector: left.getVectorPart() - right,
                    scalar: left.getScalarPart())
    }

    public static func *(left: Self, right: Self) -> Self
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

    public static func *(left: Self, right: Float) -> Self
    {
        let resultData = left.data * right
        return Self(x: resultData.x,
                    y: resultData.y,
                    z: resultData.z,
                    w: resultData.w)
    }

    public static func *(left: Float, right: Self) -> Self
    {
        let resultData = right.data * left
        return Self(x: resultData.x,
                    y: resultData.y,
                    z: resultData.z,
                    w: resultData.w)
    }

    public static func /(left: Self, right: Float) -> Self
    {
        let resultData = left.data / right
        return Self(x: resultData.x,
                    y: resultData.y,
                    z: resultData.z,
                    w: resultData.w)
    }

    public func getVectorPart() -> Vector3  { self.data.xyz() }
    public func getScalarPart() -> Float    { self.data.w }

    public func conjugate() -> Self
    {
        let v = -self.getVectorPart()
        let s = self.getScalarPart()

        return Self(vector: v, scalar: s)
    }

    public func magnitude() -> Float
    {
        sqrt( pow(data.x, 2) + pow(data.y, 2) + pow(data.z, 2) + pow(data.w, 2) )
    }

    // The product of a quaternion and its conjugate. It'll always be a
    // quaternion with a vector part of (0,0,0)
    public func magnitude2() -> Float
    {
        let r = self * self.conjugate()
        return r.getScalarPart()
    }

    public func inverse() -> Self?
    {
        let m2 = self.magnitude2()
        if m2 == 0 { return nil }

        return self.conjugate() / m2
    }

    // MARK: - Private
    private var data: Vector4
}
