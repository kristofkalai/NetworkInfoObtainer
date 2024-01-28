//
//  DummyNetworkReachability.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public final class DummyNetworkReachability {
    public var whenReachable: ((DummyNetworkReachability) -> Void)?
    public var whenUnreachable: ((DummyNetworkReachability) -> Void)?
}

extension DummyNetworkReachability: NetworkReachability {
    public func startNotifier() {}
    public func stopNotifier() {}
}
