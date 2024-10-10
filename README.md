# ScrobbleKit

ScrobbleKit is a modern Swift library designed to simplify interactions with the [Last.fm API](https://www.last.fm/api) on Apple platforms. It provides a clean, async/await-based interface for seamless integration with your Swift apps.


## Getting Started

To begin using ScrobbleKit, you'll need to create an instance of `SBKManager` by providing your [API and Secret key from Last.fm](https://www.last.fm/api/account/create).

```swift
import ScrobbleKit

let manager = SBKManager(apiKey: "YOUR_API_KEY", secret: "YOUR_SECRET_KEY")
```

## Usage

ScrobbleKit supports async/await for all API methods. Here's an example of how to fetch album information:

```swift
do {
    let album = try await manager.getInfo(forAlbum: .albumArtist(album: "Random Access Memories",
                                                                 artist: "Daft Punk"))
    print("Album name: \(album.name)")
    print("Artist: \(album.artist)")
    print("Tracks: \(album.tracklist.count)")
} catch {
    print("Error fetching album info: \(error)")
}
```

## Authentication

For methods requiring authentication, you'll need to start a session:

```swift
do {
    let session = try await manager.startSession(username: "YOUR_USERNAME", password: "YOUR_PASSWORD")
    print("Authenticated as: \(session.name)")
} catch {
    print("Authentication failed: \(error)")
}
```

## Documentation

For detailed information on all available API methods and models, check out the [full documentation](https://tfmart.github.io/ScrobbleKit/documentation/scrobblekit/).

## Requirements

- iOS 13.0+
- macOS 10.15+
- watchOS 6.0+
- tvOS 13.0+
- Swift 5.5+

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/tfmart/ScrobbleKit.git", from: "0.1.0")
]
```

Or add it directly in Xcode using File > Add Packages > Search or Enter Package URL.

## Contributing

Contributions to ScrobbleKit are welcome! Please feel free to submit a Pull Request or to open an Issue.

## License

ScrobbleKit is available under the MIT license. See the LICENSE file for more info.
