import Vectors

// NOTE: Column-major
public protocol SquareMatrix : Equatable
{
    associatedtype ColumnType: Vector where ColumnType.ItemType == Double

    var contents: [[Double]] {get set}

    static func zero()     -> Self
    static func identity() -> Self

    func getColumn(_ col: Int) -> ColumnType

    // TODO: static func /(left: Self, right: Self) -> Self?
    // TODO: func inv() -> Self
    // TODO: func det() -> Double

    // TODO: Transforms
}

extension SquareMatrix
{
    public func getDimensions() -> Int
    {
        return self.contents.count
    }

    public func get(col: Int, row: Int) -> Double
    {
        assert(col < self.contents.count,    "ERROR: Column \(col) is out of bounds")
        assert(row < self.contents[0].count, "ERROR: Row \(row) is out of bounds")

        return self.contents[col][row]
    }

    mutating func set(col: Int, row: Int, val: Double)
    {
        assert(col < self.contents.count,    "ERROR: Column \(col) is out of bounds")
        assert(row < self.contents[0].count, "ERROR: Row \(row) is out of bounds")

        self.contents[col][row] = val
    }

    public func asSingleArray() -> [Double]
    {
        var result = [Double]()
        for column in self.contents {
            for value in column
            {
                result.append(value)
            }
        }
        return result
    }

    public static func +(left: Self, right: Self) -> Self
    {
        let n = left.getDimensions()
        var result = left
        for i in 0..<n {
            for j in 0..<n
            {
                let x = left.get(col:i, row:j) + right.get(col:i, row:j)
                result.set(col:i, row:j, val:x)
            }
        }

        return result
    }

    public static func -(left: Self, right: Self) -> Self
    {
        let n = left.getDimensions()
        var result = left
        for i in 0..<n {
            for j in 0..<n
            {
                let x = left.get(col:i, row:j) - right.get(col:i, row:j)
                result.set(col:i, row:j, val:x)
            }
        }

        return result
    }

    public static func *(right: Self, left: Self) -> Self
    {
        let n = right.getDimensions()

        var result = right
        for i in 0..<n {
            for j in 0..<n
            {
                var accumulated = 0.0
                for k in 0..<n
                {
                    accumulated += left.get(col:k, row:j) * right.get(col:i, row: k)
                }
                result.set(col:i, row:j, val: accumulated)
            }
        }
        return result
    }

    public static func *(left: Self, right: ColumnType) -> ColumnType
    {
        let n = left.getDimensions()

        var result = ColumnType.zero()
        for i in 0..<n {
            for j in 0..<n
            {
                result[i] += left.get(col:j, row:i) * right[j]
            }
        }
        return result
    }

    public static func ==(left: Self, right: Self) -> Bool
    {
        let n = left.getDimensions()

        var result = true
        for i in 0..<n {
            for j in 0..<n
            {
                let a = left.get(col:i, row:j)
                let b = right.get(col:i, row:j)
                result = a == b
                if !result { break }
            }
        }
        return result
    }
}
