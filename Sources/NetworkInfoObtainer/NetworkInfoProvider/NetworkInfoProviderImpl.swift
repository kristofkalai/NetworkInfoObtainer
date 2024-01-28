//
//  NetworkInfoProviderImpl.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public final class NetworkInfoProviderImpl<T: NetworkReachability> {
    private let ipAddressChangeNotifier: IpAddressChangeNotifier
    private let networkReachability: T?

    public var ipAddressDidChange: ((NetworkInfo) -> Void)? {
        didSet {
            ipAddressDidChange?(ipAddressChangeNotifier.networkInfo)
        }
    }
    public var networkInfo = NetworkInfo() {
        didSet {
            ipAddressDidChange?(ipAddressChangeNotifier.networkInfo)
        }
    }

    public init(ipAddressChangeNotifier: IpAddressChangeNotifier, networkReachability: T?) {
        self.ipAddressChangeNotifier = ipAddressChangeNotifier
        self.networkReachability = networkReachability
        setup()
    }

    deinit {
        stopNotifier()
    }
}

extension NetworkInfoProviderImpl: NetworkInfoProvider {
    public func startNotifier() throws {
        stopNotifier()
        ipAddressChangeNotifier.startNotifier(interval: 1)
        try networkReachability?.startNotifier()
    }
    
    public func stopNotifier() {
        ipAddressChangeNotifier.stopNotifier()
        networkReachability?.stopNotifier()
    }
}

extension NetworkInfoProviderImpl where T == DummyNetworkReachability {
    public convenience init(ipAddressChangeNotifier: IpAddressChangeNotifier) {
        self.init(ipAddressChangeNotifier: ipAddressChangeNotifier, networkReachability: nil)
    }
}

extension NetworkInfoProviderImpl {
    private func setup() {
        networkReachability?.whenReachable = { [weak self] _ in
            self?.update()
        }

        networkReachability?.whenUnreachable = { [weak self] _ in
            self?.update()
        }

        ipAddressChangeNotifier.ipAddressDidChange = { [weak self] in
            self?.update(networkInfo: $0)
        }
    }

    private func update(networkInfo updatedNetworkInfo: NetworkInfo? = nil) {
        let previousNetworkInfo = networkInfo

        let updatedNetworkInfo = updatedNetworkInfo ?? ipAddressChangeNotifier.networkInfo

        if previousNetworkInfo != updatedNetworkInfo {
            networkInfo = updatedNetworkInfo
        }
    }
}
