# Scrobbling Tracks

Get started on scrobbling songs to a Last.fm profile

## Overview

Ensure you are authenticated with a valid session token for a Last.fm account before initiating the scrobbling process. If you haven't authenticated yet, If you need help on how to authenticate, refer to the <doc:Authentication> for assistance.

### Scrobbling a Single Track

To scrobble a single track, you can use the `scrobble(tracks:)` method with an array containing just one ``SBKTrackToScrobble``:

```swift
let track = SBKTrackToScrobble(
    artist: "Daft Punk",
    track: "One More Time",
    timestamp: Date(),
    album: "Discovery"
)

do {
    let response = try await SBKManager.scrobble(tracks: [track])
    
    if response.isCompletelySuccessful {
        print("Track scrobbled successfully!")
    } else {
        if let result = response.results.first {
            if result.isAccepted {
                print("Scrobbled: \(result.track.artist) - \(result.track.track)")
                if let correctedArtist = result.correctedArtist {
                    print("Artist corrected to: \(correctedArtist)")
                }
                if let correctedTrack = result.correctedTrack {
                    print("Track corrected to: \(correctedTrack)")
                }
            } else if let error = result.error {
                print("Failed to scrobble \(result.track.artist) - \(result.track.track): \(error.rawValue)")
            }
        }
    }
} catch {
    // Handle scrobbling error
}
```

### Scrobbling Multiple Tracks

To scrobble multiple tracks at once, use the `scrobble(tracks:)` method:

```swift
let tracks: [SBKTrackToScrobble] = [
    SBKTrackToScrobble(artist: "Daft Punk", track: "One More Time", timestamp: Date(), album: "Discovery"),
    SBKTrackToScrobble(artist: "Daft Punk", track: "Harder, Better, Faster, Stronger", timestamp: Date(), album: "Discovery")
]

do {
    let response = try await SBKManager.scrobble(tracks: tracks)
    
    if response.isCompletelySuccessful {
        print("All tracks scrobbled successfully!")
    } else {
        print("Accepted: \(response.acceptedCount), Ignored: \(response.ignoredCount)")
        
        for result in response.results {
            if result.isAccepted {
                print("Scrobbled: \(result.track.artist) - \(result.track.track)")
            } else if let error = result.error {
                print("Failed to scrobble \(result.track.artist) - \(result.track.track): \(error.rawValue)")
            }
        }
    }
} catch {
    // Handle scrobbling error
}
```

### Handling the response

The `scrobble(tracks:)` method returns an `SBKScrobbleResponse` object, which contains:

- `results`: An array of ``SBKScrobbleResult`` objects, one for each track attempted to be scrobbled.
- `acceptedCount`: The number of tracks successfully scrobbled.
- `ignoredCount`: The number of tracks that failed to scrobble.
- `isCompletelySuccessful`: A boolean indicating if all tracks were successfully scrobbled.
- `acceptedScrobbles`: An array of ``SBKScrobbleResult`` objects for successfully scrobbled tracks.
- `ignoredScrobbles`: An array of ``SBKScrobbleResult`` objects for tracks that failed to scrobble.

Each `SBKScrobbleResult` contains:

- `track`: The ``SBKTrackToScrobble`` object that was attempted to be scrobbled.
- `isAccepted`: A boolean indicating if the track was successfully scrobbled.
- `error`: An ``SBKScrobbleError`` object if the scrobble failed, `nil` otherwise.
- `correctedTrack`, `correctedArtist`, `correctedAlbum`, `correctedAlbumArtist`: Corrected values if Last.fm made any corrections.

You can scrobble up to 50 tracks in a single request. Attempting to scrobble more than 50 tracks will result in a ``SBKClientError.tooManyTracks`` error.

### Convenience Methods

The ``SBKManager`` provides two convenience methods for checking scrobble results:

```swift
// Check if a specific track was successfully scrobbled
let wasScrobbled = manager.scrobbledSuccessfully(tracks[0], in: response)

// Get the error for a specific track, if any
if let error = manager.errorFor(tracks[1], in: response) {
    print("Scrobble failed: \(error.rawValue)")
}
```

These methods provide a quick way to check if the single track was scrobbled successfully or if there was an error.
