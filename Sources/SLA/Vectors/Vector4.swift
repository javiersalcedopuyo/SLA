public typealias Vector4 = SIMD4<Float>

public extension Vector4
{
    // MARK: - Initialisers
    init(xyz: Vector3, w: Float) { self.init(xyz.x, xyz.y, xyz.z, w) }
    static func identity() -> Self { Self.one }
    static func zero()     -> Self { Self.zero } // To keep previous API behaviour

    // MARK: - Accessors
    // To keep previous API behaviour
    func x() -> Float { self.x }
    func y() -> Float { self.y }
    func z() -> Float { self.z }
    func w() -> Float { self.w }

    func r() -> Float { self.x }
    func g() -> Float { self.y }
    func b() -> Float { self.z }
    func a() -> Float { self.w }

    func xyz() -> Vector3 { return Vector3(self.x, self.y, self.z) }
    func rgb() -> Vector3 { return Vector3(self.x, self.y, self.z) }
    // TODO: More combinations

    // MARK: - Operators
    func dot (_ right: Self) -> Float
    {
        return  self.x * right.x +
                self.y * right.y +
                self.z * right.z +
                self.w * right.w
    }

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
