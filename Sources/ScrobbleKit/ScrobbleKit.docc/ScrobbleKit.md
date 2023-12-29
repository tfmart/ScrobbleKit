# ``ScrobbleKit``

Streamlined interaction with Last.fm on Apple platforms

## Overview

ScrobbleKit is a Swift package that simplifies the integration of Last.fm's API across all the Apple platforms, enabling the creation of applications that interact seamlessly with the popular music platform.

This package encompasses a comprehensive set of Last.fm API methods, providing developers with the tools to perform essential tasks such as scrobbling tracks, retrieving user charts, obtaining detailed album information, and supporting a wide range of other functionalities available in the Last.fm API catalog.

To begin using ScrobbleKit, you can check out our <doc:QuickStart> guide for an easy introduction. Alternatively, you can select one of the topics below to go through specific functionalities in ScrobbleKit with step-by-step instructions.

## Topics

### Authenticating an User

- ``SBKManager/startSession(username:password:)``
- ``SBKManager/setSessionKey(_:)``
- ``SBKSessionResponse``

### Scrobbling

- ``SBKManager/scrobble(track:artist:album:)``
- ``SBKScrobbleResponse``
