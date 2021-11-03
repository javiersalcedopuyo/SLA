public typealias Vector2 = SIMD2<Float>

public extension Vector2
{
    static func identity() -> Self { Self.one }
    static func zero()     -> Self { Self.zero } // To keep previous API behaviour

    // MARK: - Accessors
    // To keep previous API behaviour
    func x() -> Float { self.x }
    func y() -> Float { self.y }

    // MARK: - Operators
    func dot(_ right: Self) -> Float { self.x * right.x + self.y * right.y }

    func norm2() -> Float { return self.dot(self) }
    func norm()  -> Float { return self.dot(self).squareRoot() }

    func normalized() -> Self
    {
        let n = self.norm2()
        return n > 0 ? self / n.squareRoot()
                     : Self.zero
    }

    func projectOnto(_ b: Self) -> Self { return b * (self.dot(b) / b.norm2()) }
    func reject(_ b: Self)      -> Self { return self - self.projectOnto(b) }
}
