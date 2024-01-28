//
//  IpAddressChangeNotifier.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

import Foundation

public protocol IpAddressChangeNotifier: AnyObject, NetworkInfoProvider {
    func startNotifier(interval: TimeInterval)
}

extension IpAddressChangeNotifier {
    public func startNotifier() {
        startNotifier(interval: 1)
    }
}
