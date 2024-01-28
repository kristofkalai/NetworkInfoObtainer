//
//  NetworkReachability.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public protocol NetworkReachability: AnyObject, Notifier {
    var whenReachable: ((Self) -> Void)? { get set }
    var whenUnreachable: ((Self) -> Void)? { get set }
}
