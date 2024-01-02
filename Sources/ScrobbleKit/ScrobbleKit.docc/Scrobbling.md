# Scrobbling Tracks

Get started on scrobbling songs to a Last.fm profile

## Overview

Ensure you are authenticated with a valid session token for a Last.fm account before initiating the scrobbling process. If you haven't authenticated yet, If you need help on how to authenticate, refer to the <doc:Authentication> for assistance.

### Scrobbling a Track

To scrobble a track, use the ``SBKManager/scrobble(track:artist:album:)`` method, supporting both Async/Await and Completion Handler approaches. In order to log a song, provide the following metadata from it:

- Title: The name of the song
- Artist: The artist of the track
- 	Album (optional): The name of the album to which the track belongs

Then, use the method as follows:

```swift
let track: String = "One More Time"
let artist: String = "Daft Punk"
let album: String? = "Discovery"

do {
    let response = try await SBKManager.scrobble(track: track,
                                                 artist: artist,
                                                 album: album)
} catch {
    // Handle scrobbling error
}
```

### Handling the response

Upon successful scrobbling, an instance of ``SBKScrobbleResponse`` is returned. This response provides information about the scrobbled tracks and any corrections made to metadata to avoid typos or outdated aliases.

To check the number of scrobbled and ignored tracks, use the ``SBKScrobbleResponse/successfulScrobbles`` and ``SBKScrobbleResponse/ignoredTracks`` properties:

```swift
let response = try await SBKManager.scrobble(track: track,
                                             artist: artist,
                                             album: album)

let hasScrobbled = response.scrobbledTracks == 1 && response.ignoredTracks == 0
```

- Tip: Currently, ScrobbleKit only supports scrobbling one song at a time. If scrobbledTracks is `1` and ignoredTracks is `0`, assume the song has been successfully logged.

The ``SBKScrobbleResponse/tracks`` contains all the tracks that have been submitted to the service and each one contains the status of if it has been successfully logged or not throguh the ``SBKScrobbleResponseTrack/status`` property.

```swift
let response = try await SBKManager.scrobble(track: track,
                                             artist: artist,
                                             album: album)

for track in response.track {
    switch track.status {
    case .accepted: return
    case let .ignored(message):
        // Check ignored reason through provided message
    }
}

```

You can check if any correction has been applied by checking the ``SBKScrobbleResponseTrack/correctedAttributes`` property of a track:

```swift
let response = try await SBKManager.scrobble(track: track,
                                             artist: artist,
                                             album: album)

let scrobbledTrack = response.tracks.first(where: { //... })
let correctedAttributes = scrobbledTrack.correctedAttributes

if correctedAttributes.contains(.title) {
    let correctTrackTitle = scrobbledTrack.title
}
```
