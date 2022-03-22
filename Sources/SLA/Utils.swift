let FLOAT_EPSILON: Float = 0.000002

func areAlmostEqual(_ a: Float, _ b: Float) -> Bool
{
    return abs(a - b) <= FLOAT_EPSILON
}

// Linear interpolation between Vectors of Floats
func lerp<T: SIMD>(from: T, to: T, t: Float) -> T
    where T.Scalar == Float
{
    if      t <= 0.0 { return from }
    else if t >= 1.0 { return to }
    else             { return from + (to - from) * t }
}
