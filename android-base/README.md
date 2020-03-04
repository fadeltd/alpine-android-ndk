# Alpine Android Base

[![Download Size](https://images.microbadger.com/badges/image/fadeltd/alpine-android-ndk.svg)](https://microbadger.com/images/fadeltd/alpine-android-ndk)

## Content

| Path                        | Version      | Description                         |
|-----------------------------|--------------|-------------------------------------|
| extras;android;m2repository | 47.0.0       | Android Support Repository          |
| extras;google;m2repository  | 58           | Google Repository                   |
| extras;google;instantapps   | 1.8.0        | Google Play Instant Development SDK |
| patcher;v4                  | 1            | SDK Patch Applier v4                |
| platform-tools              | 29.0.6       | Android SDK Platform-Tools          |
| tools                       | 26.1.1       | Android SDK Tools                   |
| cmake_version               | 3.6.4111459  | CMake NDK                           |
| ndk-bundle                  | 21.0.6113669 | NDK Bundle                          |
| glibc_version               | 2.29-r0      | Standard C library                  |

## Extend from Alpine Android Base

In your Dockerfile use

```dockerfile
FROM fadeltd/alpine-android-ndk-base
```

this will install the packages above.

You can install any Android package [available](../packages.md). To install an Android package, include the following line on your Dockerfile:

```dockerfile
RUN ${ANDROID_HOME}/tools/bin/sdkmanager <list-of-packages>
```

If you want to install an Alpine package [available](https://pkgs.alpinelinux.org/packages?branch=v3.11). To install an Android package, include the following line on your Dockerfile:

```dockerfile
RUN apk add --no-cache <list-of-packages>
```
