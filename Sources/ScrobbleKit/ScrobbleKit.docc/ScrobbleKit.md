# ``ScrobbleKit``

Streamlined interaction with Last.fm on Apple platforms

## Overview

ScrobbleKit is a Swift package that simplifies the integration of Last.fm's API across all the Apple platforms, enabling the creation of applications that interact seamlessly with the popular music platform.

This package encompasses a comprehensive set of Last.fm API methods, providing developers with the tools to perform essential tasks such as scrobbling tracks, retrieving user charts, obtaining detailed album information, and supporting a wide range of other functionalities available in the Last.fm API catalog.

To begin using ScrobbleKit, you can check out our <doc:QuickStart> guide for an easy introduction. Alternatively, you can select one of the topics below to go through specific functionalities in ScrobbleKit with step-by-step instructions.

## Topics

### Authentication
- <doc:Authentication>
- ``SBKSessionResponseInfo``
- ``SBKManager/startSession(username:password:)-76puy``
- ``SBKManager/setSessionKey(_:)``

### Scrobbling and Now Playing
- <doc:Scrobbling>
- ``SBKScrobbleResponse``
- ``SBKManager/scrobble(track:artist:album:)``
- ``SBKNowPlayingCorrected``
- ``SBKManager/updateNowPlaying(artist:track:album:trackNumber:context:mbid:duration:albumArtist:)``

### Add Tags
- ``SBKManager/addTags(toArtist:tags:)``
- ``SBKManager/addTags(toAlbum:artist:tags:)``
- ``SBKManager/addTags(toTrack:artist:tags:)``

### Remove Tags
- ``SBKManager/removeTag(fromArtist:tag:)``
- ``SBKManager/removeTag(fromTrack:artist:tag:)``

### Get Info
- ``SBKManager/getInfo(forArtist:autocorrect:username:language:)``
- ``SBKManager/getInfo(forAlbum:autoCorrect:username:languageCode:)``
- ``SBKManager/getInfo(forTrack:artist:username:autoCorrect:languageCode:)``
- ``SBKManager/getInfo(forUser:)``

### Get Tags
- ``SBKManager/getTags(forArtist:user:autocorrect:)``
- ``SBKManager/getTags(forAlbum:autoCorrect:username:)``
- ``SBKManager/getTags(forTrack:autoCorrect:username:)``

### Get Top Tags
- ``SBKManager/getTopTags(forAlbum:autoCorrect:)``
- ``SBKManager/getTopTagsForTrack(searchMethod:autoCorrect:)``
- ``SBKManager/getTopTags(forUser:limit:)``

### Search
- ``SBKManager/search(artist:limit:page:)``
- ``SBKManager/search(album:page:limit:)``
- ``SBKManager/search(track:artist:limit:page:)``

### Get Similar
- ``SBKManager/getSimilarArtists(_:limit:autoCorrect:)``
- ``SBKManager/getSimilarTracks(_:autoCorrect:limit:)``

### Get Top Items
- ``SBKManager/getTopAlbums(forArtist:limit:page:autoCorrect:)``
- ``SBKManager/getArtistTopTracks(_:limit:page:autoCorrect:)``
- ``SBKManager/getTopAlbums(forUser:period:limit:page:)``
- ``SBKManager/getTopArtists(forUser:period:limit:page:)``
- ``SBKManager/getTopTracks(forUser:period:limit:page:)``

### Charts
- ``SBKManager/getArtistsChart(page:limit:)``
- ``SBKManager/getTagsChart(page:limit:)``
- ``SBKManager/getTracksChart(limit:page:)``

### Geo
- ``SBKManager/getTopArtists(forCountry:limit:page:)``
- ``SBKManager/getTopTracks(forCountry:limit:page:)``

### User-specific
- ``SBKManager/getFriends(for:recentTracks:limit:page:)``
- ``SBKManager/getLovedTracks(fromUser:limit:page:)``
- ``SBKManager/getPersonalTagsForAlbums(fromUser:tag:limit:page:)``
- ``SBKManager/getPersonalTagsForTracks(fromUser:tag:limit:page:)``
- ``SBKManager/getPersonalTagsForArtists(fromUser:tag:limit:page:)``
- ``SBKManager/getRecentTracks(fromUser:limit:page:from:extended:to:)``
- ``SBKManager/getArtistsFromLibrary(from:limit:page:)``

### Love/Unlove Tracks
- ``SBKManager/loveTrack(track:artist:)``
- ``SBKManager/unloveTrack(track:artist:)``

### Corrections
- ``SBKManager/getCorrectedArtistName(_:)``
- ``SBKManager/getCorrectedTrackInfo(for:by:)``
