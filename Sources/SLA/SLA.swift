public let FLOAT_EPSILON: Float = 0.000002
public let PI  = Float.pi
public let TAU = Float.pi * 2.0

public func deg2rad(_ d: Float) -> Float
{
    return d * TAU / 360.0
}

public func rad2deg(_ r: Float) -> Float
{
    return r * 360.0 / TAU
}

public func areAlmostEqual(_ a: Float, _ b: Float) -> Bool
{
    return abs(a - b) <= FLOAT_EPSILON
}

// Linear interpolation between Vectors of Floats
public func lerp<T: SIMD>(from: T, to: T, t: Float) -> T
    where T.Scalar == Float
{
    if      t <= 0.0 { return from }
    else if t >= 1.0 { return to }
    else             { return from + (to - from) * t }
}

public func rotate(vector: Vector3, quaternion q: Quaternion) throws -> Vector3
{
    guard let qi = q.inverse() else
    {
        throw QuaternionErrors.NoInverse
    }

    let v = Quaternion(vector: vector, scalar: 0)

    return (q * v * qi).getVectorPart()
}

public func makeRotationMatrixFrom(quaternion: Quaternion) -> Matrix3x3
{
    let x = quaternion.getVectorPart().x
    let y = quaternion.getVectorPart().y
    let z = quaternion.getVectorPart().z
    let w = quaternion.getScalarPart()

    let x2 = x * x
    let y2 = y * y
    let z2 = z * z

    let xy = x * y
    let xz = x * z
    let yz = y * z

    let wx = w * x
    let wy = w * y
    let wz = w * z

    let A = Vector3(x: 1 - 2 * y2 - 2 * z2,
                    y: 2 * (xy + wz),
                    z: 2 * (xz - wy))

    let B = Vector3(x: 2 * (xy - wz),
                    y: 1 - 2 * x2 - 2 * z2,
                    z: 2 * (yz + wx))

    let C = Vector3(x: 2 * (xz + wy),
                    y: 2 * (yz - wx),
                    z: 1 - 2 * x2 - 2 * y2)

    return Matrix3x3(a: A, b: B, c: C)
}

// TODO: public func makeQuaternionFrom(rotationMatrix: Matrix3x3) -> Quaternion