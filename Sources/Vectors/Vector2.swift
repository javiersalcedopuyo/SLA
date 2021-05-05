public struct Vector2 : Vector
{
    public var contents: [Double]

    // INITIALISERS
    public init(x: Double, y: Double)     { contents = [x, y] }
    public static func zero()     -> Self { return Vector2(x:0, y:0) }
    public static func identity() -> Self { return Vector2(x:1, y:1) }

    // ACCESSORS
    public func x() -> Double { return self.contents[0] }
    public func y() -> Double { return self.contents[1] }

    public static func lerp(from: Self, to: Self, t: Double)  -> Self
    {
        if      t <= 0.0 { return from }
        else if t >= 1.0 { return to }
        else             { return from + (to - from) * t }
    }
}