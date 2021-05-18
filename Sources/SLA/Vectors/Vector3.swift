public struct Vector3 : Vector
{
    public static let size = 3 * MemoryLayout<Float>.size
    public var contents: [Float]

    // INITIALISERS
    public init(x: Float, y: Float, z: Float) { contents = [x, y, z] }
    public init(r: Float, g: Float, b: Float) { contents = [r, g, b] }
    public static func zero()     -> Self        { return Vector3(x:0, y:0, z:0) }
    public static func identity() -> Self        { return Vector3(x:1, y:1, z:1) }

    // ACCESSORS
    public func x() -> Float { return self.contents[0] }
    public func y() -> Float { return self.contents[1] }
    public func z() -> Float { return self.contents[2] }
    public func r() -> Float { return self.contents[0] }
    public func g() -> Float { return self.contents[1] }
    public func b() -> Float { return self.contents[2] }

    // VECTOR ARITHMETIC
    public func cross(_ right: Self) -> Self
    {
        return Vector3(x: self.y() * right.z() - self.z() * right.y(),
                       y: self.z() * right.x() - self.x() * right.z(),
                       z: self.x() * right.y() - self.y() * right.x())
    }

    public static func lerp(from: Self, to: Self, t: Float)  -> Self
    {
        if      t <= 0.0 { return from }
        else if t >= 1.0 { return to }
        else             { return from + (to - from) * t }
    }
}