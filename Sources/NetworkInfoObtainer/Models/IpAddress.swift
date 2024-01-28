//
//  IpAddress.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

struct IpAddress {
    private let ifaddrs: Ifaddrs
}

extension IpAddress {
    var hostname: String {
        ifaddrs.hostname
    }

    func matching(with matchingInterface: (String) -> Bool) -> Bool {
        ifaddrs.matching(with: matchingInterface)
    }

    static var addresses: [IpAddress]? {
        Ifaddrs.using {
            $0.flatMap {
                $0.addresses
                    .map { IpAddress(ifaddrs: $0) }
            }
        }
    }
}
