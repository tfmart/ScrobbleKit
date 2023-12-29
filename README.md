# ScrobbleKit

A Swift library to interact with the [Last.fm API](https://www.last.fm/api) for Apple platforms

# Getting Started

Create an instance of `SBKManager` with your [API and Secret key from Last.fm](https://www.last.fm/api/account/create)

```swift
import ScrobbleKit

let manager = SBKManager(apiKey: API_KEY,
                         secret: SECRET_KEY)
```

You can use the available API methods through the manager, which has support for both async/await and a completion handler based

```swift
// async/await
let album = await manager.getInfo(forAlbum: .albumArtist(album: "Random Access Memories",
                                                         artist: "Daft Punk"))

// completion handler
manager.getInfo(forAlbum: .albumArtist(album: "Random Access Memories",
                                       artist: "Daft Punk"))
{ album, error in
    // ...
}
```

For more information of API methods available through ScrobbleKit, read the [full documentation]()

# Requirements

- iOS 13.0 or later
- macOS Catalina or later
- watchOS 6.0 or later 
- tvOS 13.0 or later
