public struct Vector2 : Vector
{
    public static let size = 2 * MemoryLayout<Float>.size
    public var contents: [Float]

    // INITIALISERS
    public init(x: Float, y: Float)     { contents = [x, y] }
    public static func zero()     -> Self { return Vector2(x:0, y:0) }
    public static func identity() -> Self { return Vector2(x:1, y:1) }

    // ACCESSORS
    public func x() -> Float { return self.contents[0] }
    public func y() -> Float { return self.contents[1] }

    public static func lerp(from: Self, to: Self, t: Float)  -> Self
    {
        if      t <= 0.0 { return from }
        else if t >= 1.0 { return to }
        else             { return from + (to - from) * t }
    }
}