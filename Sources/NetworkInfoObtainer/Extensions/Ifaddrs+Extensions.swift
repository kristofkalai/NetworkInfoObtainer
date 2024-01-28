//
//  Ifaddrs+Extensions.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

import Foundation

typealias Ifaddrs = ifaddrs

extension Ifaddrs {
    private static func create() -> UnsafeMutablePointer<Ifaddrs>? {
        var ifaddrs: UnsafeMutablePointer<Ifaddrs>?
        getifaddrs(&ifaddrs)
        return ifaddrs
    }
}

extension Ifaddrs {
    @discardableResult static func using<T>(_ block: (UnsafeMutablePointer<Ifaddrs>?) -> T) -> T {
        let ifaddrs = create()
        let result = block(ifaddrs)
        freeifaddrs(ifaddrs)
        return result
    }

    func matching(with matchingInterface: (String) -> Bool) -> Bool {
        ifa_addr.pointee.sa_family == UInt8(AF_INET) && matchingInterface(String(cString: ifa_name))
    }

    var hostname: String {
        var hostname = [CChar](repeating: .zero, count: Int(NI_MAXHOST))
        getnameinfo(ifa_addr,
                    socklen_t(ifa_addr.pointee.sa_len),
                    &hostname,
                    socklen_t(hostname.count),
                    nil,
                    .zero,
                    NI_NUMERICHOST)
        return String(cString: hostname)
    }
}

extension UnsafeMutablePointer<Ifaddrs> {
    private var unfoldSequence: UnfoldFirstSequence<Self> {
        sequence(first: self) { $0.pointee.ifa_next }
    }

    var addresses: [Ifaddrs] {
        unfoldSequence.map(\.pointee)
    }
}
