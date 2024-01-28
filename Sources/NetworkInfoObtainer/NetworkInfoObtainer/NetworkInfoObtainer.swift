//
//  NetworkInfoObtainer.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public protocol NetworkInfoObtainer: AnyObject {
    func ipAddress(for matchingInterface: (String) -> Bool) -> String?
}

extension NetworkInfoObtainer {
    public func ipAddress(for networkInterface: NetworkInterface) -> String? {
        ipAddress(for: networkInterface.matching)
    }

    public var networkInfo: NetworkInfo {
        .init(
            wifiIpAddress: ipAddress(for: .wifi),
            cellularIpAddress: ipAddress(for: .cellular),
            vpnIpAddress: ipAddress(for: .vpn)
        )
    }
}
