//
//  NetworkInfoProvider.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public protocol NetworkInfoProvider: AnyObject, Notifier {
    var ipAddressDidChange: ((NetworkInfo) -> Void)? { get set }
    var networkInfo: NetworkInfo { get }
}
