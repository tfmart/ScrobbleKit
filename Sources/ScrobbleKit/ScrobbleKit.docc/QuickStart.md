# Quick Start

A quick start guide on how to start using ScrobbleKit on your app

## Overview

### Creating a Last.fm API Key

To utilize the Last.fm API, obtain a valid API and Secret key. If you don't have these keys, you can create them on the [Last.fm API portal](https://www.last.fm/api/account/create).

### Add ScrobbleKit as a dependency

ScrobbleKit can be added to your projects through Swift Package Manager. If you're adding it to another Swift Package, add ScrobbleKit to your `Package.swift` file:

```swift
let package = Package(
    ...
    dependencies: [
        ...
        .package(url: "https://github.com/tfmart/scrobblekit.git", from: "0.1.0")
    ],
    targets: [
        .executableTarget(
            ...
            dependencies: [.product(name: "ScrobbleKit", package: "ScrobbleKit")],
            ...
        )
    ]
)
```

For Xcode projects, search for the package with the repository URL `github.com/tfmart/scrobblekit` to add it as a dependency to iOS, macOS, or macCatalyst targets.

### Creating a SBKManager instance

After integrating ScrobbleKit, instantiate the ``SBKManager`` using the ``SBKManager/init(apiKey:secret:)`` initializer. This class facilitates the invocation of available API methods, utilizing the API and Secret keys provided during initialization.

```swift
let manager = SBKManager(apiKey: API_KEY,
                         secret: SECRET_KEY)
```

Throughout your app, use this manager class to access Last.fm API methods provided in the library. Since ``SBKManager`` inherits from `ObservableObject`, in a SwiftUI app, share this instance through a `StateObject`:

```swift
@main
struct MyMusicApp: App {
    @StateObject var manager = SBKManager(apiKey: API_KEY,
                                          secret: SECRET_KEY)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}
```

Subsequently, import the manager property into a view:

```swift
struct ContentView: View {
    @EnvironmentObject var manager: SBKManager

    var body: some View {
        // ...
    }
}

```

### Calling API methods

To utilize any of the available methods, refer to the list under the ``SBKManager`` documentation. All methods support both Async/Await for modern concurrency data fetching and completion handlers for a more traditional approach.

For instance, to retrieve information from an album in the Last.fm database, utilize the  ``SBKManager/getInfo(forAlbum:autoCorrect:username:languageCode:)`` method, employing either of the following approaches:

#### Async/Await

```swift
do {
    let album = try await manager.getInfo(forAlbum: .albumArtist(album: "Random Access Memories",
                                                                 artist: "Daft Punk"))
    // Use 'album' here
} catch {
    // Handle error
}
```

#### Completion Handler

```swift
manager.getInfo(forAlbum: .albumArtist(album: "Random Access Memories",
                                       artist: "Daft Punk"))
{ album, error in
    if let album = album {
        // Use 'album' here
    } else if let error = error {
        // Handle error
    }
}
```
