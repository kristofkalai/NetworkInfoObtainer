//
//  NetworkInfo.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public struct NetworkInfo {
    public let wifiIpAddress: String?
    public let cellularIpAddress: String?
    public let vpnIpAddress: String?

    init(wifiIpAddress: String? = nil, cellularIpAddress: String? = nil, vpnIpAddress: String? = nil) {
        self.wifiIpAddress = wifiIpAddress
        self.cellularIpAddress = cellularIpAddress
        self.vpnIpAddress = vpnIpAddress
    }
}

extension NetworkInfo: Equatable {}
