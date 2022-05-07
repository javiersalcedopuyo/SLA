// NOTE: Column-major
public protocol SquareMatrix : Equatable
{
    associatedtype ColumnType: SIMD where ColumnType.Scalar: FloatingPoint
    typealias ElementType = Self.ColumnType.Scalar

    var size:      Int     { get }
    var dimension: Int     { get }
    var contents:  [ColumnType] { get set }

    static func zero()     -> Self
    static func identity() -> Self

    static func makeRotation(radians: Float, axis: ColumnType) -> Self

    // TODO: static func /(left: Self, right: Self) -> Self?
    func inverse() -> Self?
    func determinant() -> Float

    // TODO: Transforms
}

public extension SquareMatrix
{
    // MARK: - Getters and Setters
    func get(col: Int, row: Int) -> ElementType
    {
        assert(col < self.dimension, "ERROR: Column \(col) is out of bounds")
        assert(row < self.dimension, "ERROR: Row \(row) is out of bounds")
        return self.contents[col][row]
    }

    func getColumn(_ idx: Int) -> ColumnType
    {
        assert(idx < self.contents.indices.count)
        return self.contents[idx]
    }

    func asSingleArray() -> [ElementType]
    {
        var result: [ElementType] = []
        for x in 0..<self.dimension
        {
            for y in 0..<self.dimension
            {
                result.append( self.get(col: x, row: y) )
            }
        }
        return result
    }

    mutating func set(col: Int, row: Int, val: ElementType)
    {
        assert(col < self.dimension, "ERROR: Column \(col) is out of bounds")
        assert(row < self.dimension, "ERROR: Row \(row) is out of bounds")

        self.contents[col][row] = val
    }

    mutating func setColumn(idx: Int, val: ColumnType) { self.contents[idx] = val }

    // MARK: - Operators
    static func +(left: Self, right: Self) -> Self
    {
        assert(left.dimension == right.dimension)

        var result = Self.zero()
        for i in 0..<left.dimension
        {
            result.contents[i] = left.contents[i] + right.contents[i];
        }
        return result
    }

    static func -(left: Self, right: Self) -> Self
    {
        assert(left.dimension == right.dimension)

        var result = Self.zero()
        for i in 0..<left.dimension
        {
            result.contents[i] = left.contents[i] - right.contents[i];
        }
        return result
    }

    static func *(left: Self, right: Self) -> Self
    {
        assert(left.dimension == right.dimension)

        let n = right.dimension

        var result = right
        for i in 0..<n {
            for j in 0..<n
            {
                var accumulated :ElementType = 0
                for k in 0..<n
                {
                    accumulated += left.get(col:k, row:j) * right.get(col:i, row: k)
                }
                result.set(col:i, row:j, val: accumulated)
            }
        }
        return result
    }

    static func *(left: Self, right: ColumnType) -> ColumnType
    {
        assert(left.dimension == right.indices.count)

        let n = left.dimension

        var result = ColumnType.zero
        for i in 0..<n {
            for j in 0..<n
            {
                result[i] += left.get(col:j, row:i) * right[j]
            }
        }
        return result
    }

    static func /=(left: inout Self, right: ColumnType.Scalar)
    {
        left = left / right
    }

    static func /(left: Self, right: ColumnType.Scalar) -> Self
    {
        return left * (1/right)
    }

    static func *=(left: inout Self, right: ColumnType.Scalar)
    {
        left = left * right
    }

    static func *(left: Self, right: ColumnType.Scalar) -> Self
    {
        var result = left
        for i in 0..<left.contents.count
        {
            result.contents[i] = left.contents[i] * right
        }
        return result
    }


    static func ==(left: Self, right: Self) -> Bool
    {
        if left.dimension != right.dimension { return false }

        for i in 0..<left.dimension
        {
            if left.contents[i] != right.contents[i] { return false }
        }
        return true
    }

    // MARK: - Manipulation
    func transposed() -> Self
    {
        var transposed = Self.zero()

        for x in 0..<dimension {
            for y in 0..<dimension
            {
                transposed.set(col: y, row: x, val: self.get(col: x, row: y))
            }
        }

        return transposed
    }

    // TODO: func calculateDeterminant() -> ElementType

    // MARK: - Transforms
    func scaled(scalePerAxis: ColumnType) -> Self
    {
        return Self.makeScale(scalePerAxis: scalePerAxis) * self
    }

    static func makeScale(scalePerAxis: ColumnType) -> Self
    {
        var result = Self.identity()

        for i in scalePerAxis.indices
        {
            result.set(col: i, row: i, val: scalePerAxis[i])
        }

        return result
    }

    mutating func rotate(R: Self) { self = R * self }
}
