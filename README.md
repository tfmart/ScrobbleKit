# ScrobbleKit

ScrobbleKit is a Swift library designed to simplify interactions with the [Last.fm API](https://www.last.fm/api) on Apple platforms

# Getting Started

To begin using ScrobbleKit, create an instance of SBKManager by providing your [API and Secret key from Last.fm](https://www.last.fm/api/account/create)

```swift
import ScrobbleKit

let manager = SBKManager(apiKey: API_KEY,
                         secret: SECRET_KEY)
```

You can utilize the available API methods through the manager, which supports both async/await and completion handler-based approaches.

### Async/Await
```swift
do {
    let album = try await manager.getInfo(forAlbum: .albumArtist(album: "Random Access Memories",
                                                                 artist: "Daft Punk"))
    // Use 'album' here
} catch {
    // Handle error
}
```

### Completion Handler
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

For more detailed information on API methods available through ScrobbleKit, check out the [full documentation]()

# Requirements

- iOS 13.0 or later
- macOS Catalina or later
- watchOS 6.0 or later 
- tvOS 13.0 or later
