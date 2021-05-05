protocol Vector : Equatable
{
    // IDEA: Numeric instead of SignedNumeric?
    associatedtype Item: SignedNumeric, Comparable

    var contents: [Item] {get set}

    static func zero()      -> Self
    static func identity()  -> Self

    static func lerp(from: Self, to: Self, t: Double)  -> Self

    func projectOnto(_ b: Self) -> Self
    func reject(_ b: Self)      -> Self
}

// Common methods and operators
extension Vector
{
    public func length() -> Int
    {
        return self.contents.count
    }

    public mutating func clamp(min minVal: Item, max maxVal: Item)
    {
        for i in 0..<self.length()
        {
            self[i] = min( max(self[i], minVal), maxVal )
        }
    }

    public subscript(index: Int) -> Item
    {
        get
        {
            assert(index >= 0 && index < self.length(), "ERROR: Access out of bounds!")
            return self.contents[index]
        }
        set(newVal)
        {
            assert(index >= 0 && index < self.length(), "ERROR: Access out of bounds!")
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

    public static func +(left: Self, right: Item) -> Self
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

    public static func +=(left: inout Self, right: Item)
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

    public static func -(left: Self, right: Item) -> Self
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

    public static func -=(left: inout Self, right: Item)
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

    public static func *(left: Self, right: Item) -> Self
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

    public static func *=(left: inout Self, right: Item)
    {
        for i in 0..<left.length()
        {
            left[i] *= right
        }
    }
}

extension Vector where Item: FloatingPoint
{
    func dot (_ right: Self) -> Item
    {
        assert(self.length() == right.length(), "ERROR: Vector length mismatch")

        var result: Item = 0
        for i in 0..<self.length()
        {
            result += self[i] * right[i]
        }
        return result
    }

    //TODO: func wedgeProduct(_ right: Self) -> Self

    func norm2() -> Item { return self.dot(self) }
    func norm()  -> Item { return self.dot(self).squareRoot() }

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

    static func /(left: Self, right: Item) -> Self
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

    static func /=(left: inout Self, right: Item)
    {
        for i in 0..<left.length()
        {
            left[i] /= right
        }
    }
}

extension Vector where Item: SignedInteger
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

    static func /(left: Self, right: Item) -> Self
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

    static func /=(left: inout Self, right: Item)
    {
        for i in 0..<left.length()
        {
            left[i] /= right
        }
    }
}