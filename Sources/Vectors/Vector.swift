public protocol Vector : Equatable
{
    // IDEA: Numeric instead of SignedNumeric?
    associatedtype ItemType: SignedNumeric, Comparable

    var contents: [ItemType] {get set}

    static func zero()      -> Self
    static func identity()  -> Self

    static func lerp(from: Self, to: Self, t: Double)  -> Self
}

// Common methods and operators
extension Vector
{
    public func length() -> Int
    {
        return self.contents.count
    }

    public mutating func clamp(min minVal: ItemType, max maxVal: ItemType)
    {
        for i in 0..<self.length()
        {
            self[i] = min( max(self[i], minVal), maxVal )
        }
    }

    public subscript(index: Int) -> ItemType
    {
        get
        {
            assert(index >= 0 && index < self.length(), "ERROR: \(index) is out of bounds!")
            return self.contents[index]
        }
        set(newVal)
        {
            assert(index >= 0 && index < self.length(), "ERROR: \(index) is out of bounds!")
            self.contents[index] = newVal
        }
    }

    public static prefix func -(right: Self) -> Self
    {
        var result = right
        for i in 0..<right.length()
        {
            result[i] = -right[i]
        }
        return result
    }

    public static func ==(left: Self, right: Self) -> Bool
    {
        if left.length() != right.length() { return false }

        var result = true
        for i in 0..<left.length()
        {
            result = left[i] == right[i]
            if !result { break }
        }
        return result
    }

    // ADDITION
    public static func +(left: Self, right: Self) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] += right[i]
        }
        return result
    }

    public static func +(left: Self, right: ItemType) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] += right
        }
        return result
    }

    public static func +=(left: inout Self, right: Self)
    {
        for i in 0..<left.length()
        {
            left[i] += right[i]
        }
    }

    public static func +=(left: inout Self, right: ItemType)
    {
        for i in 0..<left.length()
        {
            left[i] += right
        }
    }

    // SUBTRACTION
    public static func -(left: Self, right: Self) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] -= right[i]
        }
        return result
    }

    public static func -(left: Self, right: ItemType) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] -= right
        }
        return result
    }

    public static func -=(left: inout Self, right: Self)
    {
        for i in 0..<left.length()
        {
            left[i] -= right[i]
        }
    }

    public static func -=(left: inout Self, right: ItemType)
    {
        for i in 0..<left.length()
        {
            left[i] -= right
        }
    }

    // MULTIPLICATION
    public static func *(left: Self, right: Self) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] *= right[i]
        }
        return result
    }

    public static func *(left: Self, right: ItemType) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] *= right
        }
        return result
    }

    public static func *=(left: inout Self, right: Self)
    {
        for i in 0..<left.length()
        {
            left[i] *= right[i]
        }
    }

    public static func *=(left: inout Self, right: ItemType)
    {
        for i in 0..<left.length()
        {
            left[i] *= right
        }
    }
}

extension Vector where ItemType: FloatingPoint
{
    func dot (_ right: Self) -> ItemType
    {
        assert(self.length() == right.length(), "ERROR: Vector length mismatch")

        var result: ItemType = 0
        for i in 0..<self.length()
        {
            result += self[i] * right[i]
        }
        return result
    }

    //TODO: func wedgeProduct(_ right: Self) -> Self

    func norm2() -> ItemType { return self.dot(self) }
    func norm()  -> ItemType { return self.dot(self).squareRoot() }

    func normalized() -> Self
    {
        let n = self.norm2()
        return n > 0 ? self / n.squareRoot()
                     : Self.zero()
    }

    func projectOnto(_ b: Self) -> Self { return b * (self.dot(b) / b.norm2()) }
    func reject(_ b: Self)      -> Self { return self - self.projectOnto(b) }

    // DIVISION
    static func /(left: Self, right: Self) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] /= right[i]
        }
        return result
    }

    static func /(left: Self, right: ItemType) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] /= right
        }
        return result
    }

    static func /=(left: inout Self, right: Self)
    {
        for i in 0..<left.length()
        {
            left[i] /= right[i]
        }
    }

    static func /=(left: inout Self, right: ItemType)
    {
        for i in 0..<left.length()
        {
            left[i] /= right
        }
    }
}

extension Vector where ItemType: SignedInteger
{
    // DIVISION
    static func /(left: Self, right: Self) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] /= right[i]
        }
        return result
    }

    static func /(left: Self, right: ItemType) -> Self
    {
        var result = left
        for i in 0..<left.length()
        {
            result[i] /= right
        }
        return result
    }

    static func /=(left: inout Self, right: Self)
    {
        for i in 0..<left.length()
        {
            left[i] /= right[i]
        }
    }

    static func /=(left: inout Self, right: ItemType)
    {
        for i in 0..<left.length()
        {
            left[i] /= right
        }
    }
}