# NetworkInfoObtainer
Grab the network info with ease! 🛜

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/NetworkInfoObtainer", exact: .init(0, 0, 3))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding-package-dependencies-to-your-app)

## Usage

```swift
let notifier = IpAddressChangeNotifierImpl(
    networkInfoObtainer: NetworkInfoObtainerImpl()
)
let provider = NetworkInfoProviderImpl(
    ipAddressChangeNotifier: IpAddressChangeNotifierImpl(
        networkInfoObtainer: NetworkInfoObtainerImpl()
    )
)

// ...

notifier.startNotifier(interval: 5)
notifier.ipAddressDidChange = {
    print("Notifier info: \($0)")
}

try? provider.startNotifier()
provider.ipAddressDidChange = {
    print("Provider info: \($0)")
}
```

Or to use this with the well-known [Reachability](https://github.com/ashleymills/Reachability.swift) library:

```swift
extension Reachability: NetworkReachability {}

// ...

let provider = NetworkInfoProviderImpl(
    ipAddressChangeNotifier: IpAddressChangeNotifierImpl(
        networkInfoObtainer: NetworkInfoObtainerImpl()
    ),
    networkReachability: try? Reachability()
)
```

For details see the Example app.
