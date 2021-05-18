public struct Vector4 : Vector
{
    public static let size = 4 * MemoryLayout<Float>.size
    public var contents: [Float]

    // INITIALISERS
    public init(x: Float, y: Float, z: Float, w: Float) { contents = [x, y, z, w] }
    public init(r: Float, g: Float, b: Float, a: Float) { contents = [r, g, b, a] }
    public static func zero()     -> Self                   { return Vector4(x:0, y:0, z:0, w: 0) }
    public static func identity() -> Self                   { return Vector4(x:1, y:1, z:1, w: 1) }

    // ACCESSORS
    public func x() -> Float { return self.contents[0] }
    public func y() -> Float { return self.contents[1] }
    public func z() -> Float { return self.contents[2] }
    public func w() -> Float { return self.contents[3] }
    public func r() -> Float { return self.contents[0] }
    public func g() -> Float { return self.contents[1] }
    public func b() -> Float { return self.contents[2] }
    public func a() -> Float { return self.contents[3] }

    public static func lerp(from: Self, to: Self, t: Float)  -> Self
    {
        if      t <= 0.0 { return from }
        else if t >= 1.0 { return to }
        else             { return from + (to - from) * t }
    }
}