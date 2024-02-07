//
//  ContentView.swift
//  Example
//
//  Created by Kristóf Kálai on 28/01/2024.
//

import SwiftUI
import Reachability
import NetworkInfoObtainer

extension Reachability: NetworkReachability {}

struct ContentView: View {
    private let notifier = IpAddressChangeNotifierImpl(
        networkInfoObtainer: NetworkInfoObtainerImpl()
    )
    private let provider = NetworkInfoProviderImpl(
        ipAddressChangeNotifier: IpAddressChangeNotifierImpl(
            networkInfoObtainer: NetworkInfoObtainerImpl()
        )
    )
    private let reachabilityProvider = NetworkInfoProviderImpl(
        ipAddressChangeNotifier: IpAddressChangeNotifierImpl(
            networkInfoObtainer: NetworkInfoObtainerImpl()
        ),
        networkReachability: try? Reachability()
    )
    private let reachabilityImplProvider = NetworkInfoProviderImpl(
        ipAddressChangeNotifier: IpAddressChangeNotifierImpl(
            networkInfoObtainer: NetworkInfoObtainerImpl()
        ),
        networkReachability: NetworkReachabilityImpl()
    )

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            notifier.startNotifier(interval: 5)
            notifier.ipAddressDidChange = {
                print("Notifier info: \($0)")
            }

            try? provider.startNotifier()
            provider.ipAddressDidChange = {
                print("Provider info: \($0)")
            }

            try? reachabilityProvider.startNotifier()
            reachabilityProvider.ipAddressDidChange = {
                print("ReachabilityProvider info: \($0)")
            }

            try? reachabilityImplProvider.startNotifier()
            reachabilityImplProvider.ipAddressDidChange = {
                print("ReachabilityImplProvider info: \($0)")
            }
        }
    }
}

#Preview {
    ContentView()
}
