# ``ScrobbleKit``

Streamlined interaction with Last.fm on Apple platforms

## Overview

ScrobbleKit is a Swift package that simplifies the integration of Last.fm's API across all the Apple platforms, enabling the creation of applications that interact seamlessly with the popular music platform.

This package encompasses a comprehensive set of Last.fm API methods, providing developers with the tools to perform essential tasks such as scrobbling tracks, retrieving user charts, obtaining detailed album information, and supporting a wide range of other functionalities available in the Last.fm API catalog.

To begin using ScrobbleKit, you can check out our <doc:QuickStart> guide for an easy introduction. Alternatively, you can select one of the topics below to go through specific functionalities in ScrobbleKit with step-by-step instructions.

## Topics

### Authenticating an User

- <doc:Authentication>
- ``SBKSessionResponseInfo``
- ``SBKManager/startSession(username:password:)-76puy``
- ``SBKManager/setSessionKey(_:)``

### Scrobbling

- <doc:Scrobbling>
- ``SBKScrobbleResponse``
- ``SBKManager/scrobble(track:artist:album:)``

### Update Now Playing

- ``SBKNowPlayingCorrected``
- ``SBKManager/updateNowPlaying(artist:track:album:trackNumber:context:mbid:duration:albumArtist:)``

### Artist

- ``SBKManager/addTags(toArtist:tags:)``
- ``SBKManager/getInfo(forArtist:autocorrect:username:language:)``
- ``SBKManager/getSimilarArtists(_:limit:autoCorrect:)``
- ``SBKManager/getTags(forArtist:user:autocorrect:)``
- ``SBKManager/getTopAlbums(forArtist:limit:page:autoCorrect:)``
- ``SBKManager/getArtistTopTracks(_:limit:page:autoCorrect:)``
- ``SBKManager/removeTag(fromArtist:tag:)``
- ``SBKManager/search(artist:limit:page:)``
- ``SBKManager/getCorrectedArtistName(_:)``

### Album

- ``SBKManager/addTags(toAlbum:artist:tags:)``
- ``SBKManager/getInfo(forAlbum:autoCorrect:username:languageCode:)``
- ``SBKManager/getTags(forAlbum:autoCorrect:username:)``
- ``SBKManager/getTopTags(forAlbum:autoCorrect:)``
- ``SBKManager/removeTag(fromArtist:tag:)``
- ``SBKManager/search(album:page:limit:)``
- ``SBKManager/removeTag(fromArtist:tag:)``

### Chart

- ``SBKManager/getArtistsChart(page:limit:)``
- ``SBKManager/getTagsChart(page:limit:)``
- ``SBKManager/getTracksChart(limit:page:)``

### Geo

- ``SBKManager/getTopArtists(forCountry:limit:page:)``
- ``SBKManager/getTopTracks(forCountry:limit:page:)``

### Library

- ``SBKManager/getArtistsFromLibrary(from:limit:page:)``

### Track

- ``SBKManager/addTags(toTrack:artist:tags:)``
- ``SBKManager/getCorrectedTrackInfo(for:by:)``
- ``SBKManager/getInfo(forTrack:artist:username:autoCorrect:languageCode:)``
- ``SBKManager/getSimilarTracks(_:autoCorrect:limit:)``
- ``SBKManager/getTags(forTrack:autoCorrect:username:)``
- ``SBKManager/getTopTagsForTrack(searchMethod:autoCorrect:)``
- ``SBKManager/loveTrack(track:artist:)``
- ``SBKManager/removeTag(fromTrack:artist:tag:)``
- ``SBKManager/search(track:artist:limit:page:)``
- ``SBKManager/unloveTrack(track:artist:)``
- ``SBKManager/getInfo(forTrack:artist:username:autoCorrect:languageCode:)``

### User

- ``SBKManager/getFriends(for:recentTracks:limit:page:)``
- ``SBKManager/getInfo(forUser:)``
- ``SBKManager/getLovedTracks(fromUser:limit:page:)``
- ``SBKManager/getPersonalTagsForAlbums(fromUser:tag:limit:page:)``
- ``SBKManager/getPersonalTagsForTracks(fromUser:tag:limit:page:)``
- ``SBKManager/getPersonalTagsForArtists(fromUser:tag:limit:page:)``
- ``SBKManager/getRecentTracks(fromUser:limit:page:from:extended:to:)``
- ``SBKManager/getTopAlbums(forUser:period:limit:page:)``
- ``SBKManager/getTopArtists(forUser:period:limit:page:)``
- ``SBKManager/getTopTags(forUser:limit:)``
- ``SBKManager/getTopTracks(forUser:period:limit:page:)``
