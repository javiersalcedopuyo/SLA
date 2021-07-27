import Foundation

public let PI  = Float.pi
public let TAU = Float.pi * 2.0

public func deg2rad(_ d: Float) -> Float
{
    return d * TAU / 360.0
}

public func rad2deg(_ r: Float) -> Float
{
    return r * 360.0 / TAU
}
