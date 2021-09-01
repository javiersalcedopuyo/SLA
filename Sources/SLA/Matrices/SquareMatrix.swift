// NOTE: Column-major
public protocol SquareMatrix : Equatable
{
    associatedtype ColumnType: Vector where ColumnType.ItemType == Float

    var size:      Int     { get }
    var dimension: Int     { get }
    var contents:  [Float] { get set }

    static func zero()     -> Self
    static func identity() -> Self

    static func makeRotation(radians: Float, axis: ColumnType) -> Self

    func getColumn(_ col: Int) -> ColumnType

    // TODO: static func /(left: Self, right: Self) -> Self?
    // TODO: func inv() -> Self
    // TODO: func det() -> Float

    // TODO: Transforms
}

public extension SquareMatrix
{
    func get(col: Int, row: Int) -> Float
    {
        assert(col < self.dimension, "ERROR: Column \(col) is out of bounds")
        assert(row < self.dimension, "ERROR: Row \(row) is out of bounds")

        let i = col * self.dimension + row

        return self.contents[i]
    }

    func asSingleArray() -> [Float] { return self.contents }

    mutating func set(col: Int, row: Int, val: Float)
    {
        assert(col < self.dimension, "ERROR: Column \(col) is out of bounds")
        assert(row < self.dimension, "ERROR: Row \(row) is out of bounds")

        let i = col * self.dimension + row
        self.contents[i] = val
    }

    mutating func setColumn(idx: Int, val: ColumnType)
    {
        let col = idx * self.dimension
        for i in 0..<dimension
        {
            self.contents[col+i] = val[i]
        }
    }

    // OPERATORS
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
                var accumulated :Float = 0.0
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
        assert(left.dimension == right.contents.count)

        let n = left.dimension

        var result = ColumnType.zero()
        for i in 0..<n {
            for j in 0..<n
            {
                result[i] += left.get(col:j, row:i) * right[j]
            }
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
}
