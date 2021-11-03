public typealias Vector3 = SIMD3<Float>

public extension Vector3
{
    static func identity() -> Self { Self.one }
    static func zero()     -> Self { Self.zero } // To keep previous API behaviour

    // MARK: - Accessors
    // To keep previous API behaviour
    func x() -> Float { self.x }
    func y() -> Float { self.y }
    func z() -> Float { self.z }

    func r() -> Float { self.x }
    func g() -> Float { self.y }
    func b() -> Float { self.z }

    func xy() -> Vector2 { Vector2(self.x, self.y) }
    func yz() -> Vector2 { Vector2(self.y, self.z) }
    func rg() -> Vector2 { Vector2(self.x, self.y) }
    func gb() -> Vector2 { Vector2(self.y, self.z) }

    // MARK: - Operators
    func dot (_ right: Self) -> Float
    {
        return  self.x * right.x +
                self.y * right.y +
                self.z * right.z
    }

    func cross(_ right: Self) -> Self
    {
        return Vector3(x: self.y * right.z - self.z * right.y,
                       y: self.z * right.x - self.x * right.z,
                       z: self.x * right.y - self.y * right.x)
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
