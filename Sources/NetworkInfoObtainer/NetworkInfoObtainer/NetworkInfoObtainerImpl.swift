//
//  NetworkInfoObtainerImpl.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public final class NetworkInfoObtainerImpl {
    public init() {}
}

extension NetworkInfoObtainerImpl: NetworkInfoObtainer {
    public func ipAddress(for matchingInterface: (String) -> Bool) -> String? {
        IpAddress.addresses?
            .filter { $0.matching(with: matchingInterface) }
            .map(\.hostname)
            .last
    }
}
