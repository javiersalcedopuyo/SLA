// Linear interpolation between Vectors of Floats
func lerp<T: SIMD>(from: T, to: T, t: Float) -> T
    where T.Scalar == Float
{
    if      t <= 0.0 { return from }
    else if t >= 1.0 { return to }
    else             { return from + (to - from) * t }
}
