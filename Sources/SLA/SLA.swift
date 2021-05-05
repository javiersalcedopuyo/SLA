import Foundation

public let PI  = Double.pi
public let TAU = Double.pi * 2.0

public func deg2rad(_ d: Double) -> Double
{
    return d * TAU / 360.0
}

public func rad2deg(_ r: Double) -> Double
{
    return r * 360.0 / TAU
}