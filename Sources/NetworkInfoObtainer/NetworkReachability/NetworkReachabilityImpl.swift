//
//  File.swift
//
//
//  Created by Kristóf Kálai on 07/02/2024.
//

import Foundation
import Network

public final class NetworkReachabilityImpl {
    public var whenReachable: ((NetworkReachabilityImpl) -> Void)?
    public var whenUnreachable: ((NetworkReachabilityImpl) -> Void)?

    private let monitor = NWPathMonitor()

    public init() {
        monitor.pathUpdateHandler = { [weak self] in
            guard let self else { return }

            if $0.status == .satisfied {
                whenReachable?(self)
            } else {
                whenUnreachable?(self)
            }
        }
    }
}

extension NetworkReachabilityImpl: NetworkReachability {
    public func startNotifier() {
        monitor.start(queue: .global())
    }

    public func stopNotifier() {
        monitor.cancel()
    }
}
