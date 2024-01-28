//
//  NetworkInterface.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public enum NetworkInterface {
    case wifi
    case cellular
    case vpn
}

extension NetworkInterface {
    func matching(interfaceName: String) -> Bool {
        types.contains { interfaceName.contains($0) }
    }

    private var types: [String] {
        switch self {
        case .wifi: ["en0"]
        case .cellular: ["pdp_ip0"]
        case .vpn: ["tap", "tun", "ipsec", "ppp"]
        }
    }
}
