public struct Vector3 : Vector
{
    public var contents: [Double]

    // INITIALISERS
    public init(x: Double, y: Double, z: Double) { contents = [x, y, z] }
    public init(r: Double, g: Double, b: Double) { contents = [r, g, b] }
    public static func zero()     -> Self        { return Vector3(x:0, y:0, z:0) }
    public static func identity() -> Self        { return Vector3(x:1, y:1, z:1) }

    // ACCESSORS
    public func x() -> Double { return self.contents[0] }
    public func y() -> Double { return self.contents[1] }
    public func z() -> Double { return self.contents[2] }
    public func r() -> Double { return self.contents[0] }
    public func g() -> Double { return self.contents[1] }
    public func b() -> Double { return self.contents[2] }

    // VECTOR ARITHMETIC
    public func cross(_ right: Self) -> Self
    {
        return Vector3(x: self.y() * right.z() - self.z() * right.y(),
                       y: self.z() * right.x() - self.x() * right.z(),
                       z: self.x() * right.y() - self.y() * right.x())
    }

    static func lerp(from: Self, to: Self, t: Double)  -> Self
    {
        if      t <= 0.0 { return from }
        else if t >= 1.0 { return to }
        else             { return from + (to - from) * t }
    }
}