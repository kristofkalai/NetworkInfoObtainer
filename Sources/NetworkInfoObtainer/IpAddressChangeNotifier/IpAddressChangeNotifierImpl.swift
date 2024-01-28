//
//  IpAddressChangeNotifierImpl.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

import Foundation

public final class IpAddressChangeNotifierImpl {
    public var ipAddressDidChange: ((NetworkInfo) -> Void)? {
        didSet {
            ipAddressDidChange?(networkInfo)
        }
    }
    public private(set) var networkInfo = NetworkInfo() {
        didSet {
            ipAddressDidChange?(networkInfo)
        }
    }

    private var timer: Timer?
    private let networkInfoObtainer: NetworkInfoObtainer

    public init(networkInfoObtainer: NetworkInfoObtainer) {
        self.networkInfoObtainer = networkInfoObtainer
        setup()
    }

    deinit {
        stopNotifier()
    }
}

extension IpAddressChangeNotifierImpl: IpAddressChangeNotifier {
    public func startNotifier(interval: TimeInterval) {
        stopNotifier()
        timer = .scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.updateNetworkInfo()
        }
    }

    public func stopNotifier() {
        timer?.invalidate()
    }
}

extension IpAddressChangeNotifierImpl {
    private func setup() {
        networkInfo = networkInfoObtainer.networkInfo
    }

    private func updateNetworkInfo() {
        let previousNetworkInfo = networkInfo

        let updatedNetworkInfo = networkInfoObtainer.networkInfo

        if previousNetworkInfo != updatedNetworkInfo {
            networkInfo = updatedNetworkInfo
        }
    }
}
