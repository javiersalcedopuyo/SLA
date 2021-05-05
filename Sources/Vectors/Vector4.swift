public struct Vector4 : Vector
{
    public var contents: [Double]

    // INITIALISERS
    public init(x: Double, y: Double, z: Double, w: Double) { contents = [x, y, z, w] }
    public init(r: Double, g: Double, b: Double, a: Double) { contents = [r, g, b, a] }
    public static func zero()     -> Self                   { return Vector4(x:0, y:0, z:0, w: 0) }
    public static func identity() -> Self                   { return Vector4(x:1, y:1, z:1, w: 1) }

    // ACCESSORS
    public func x() -> Double { return self.contents[0] }
    public func y() -> Double { return self.contents[1] }
    public func z() -> Double { return self.contents[2] }
    public func w() -> Double { return self.contents[3] }
    public func r() -> Double { return self.contents[0] }
    public func g() -> Double { return self.contents[1] }
    public func b() -> Double { return self.contents[2] }
    public func a() -> Double { return self.contents[3] }

    public static func lerp(from: Self, to: Self, t: Double)  -> Self
    {
        if      t <= 0.0 { return from }
        else if t >= 1.0 { return to }
        else             { return from + (to - from) * t }
    }
}