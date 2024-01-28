//
//  Notifier.swift
//
//
//  Created by Kristóf Kálai on 28/01/2024.
//

public protocol Notifier: AnyObject {
    func startNotifier() throws
    func stopNotifier()
}
