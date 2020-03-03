# Alpine Android NDK

![Build and Publish Docker](https://github.com/fadeltd/alpine-android-ndk/workflows/Build%20and%20Publish%20Docker/badge.svg)

| Alpine Android NDK Base             | Alpine Android NDK        |
|-------------------------------------|---------------------------|
| [![docker-base-pulls]][docker-base] | [![docker-pulls]][docker] |
| [![docker-base-stars]][docker-base] | [![docker-stars]][docker] |

All images are based on [openjdk:8-alpine](https://hub.docker.com/r/adoptopenjdk/openjdk8)

---

> You can use `latest` tag to always use the latest Android SDK version.

## Pull from Docker Hub

| API level         | Command                                         | Info              |
|-------------------|-------------------------------------------------|-------------------|
| Android 28 (9.0)  | `docker pull fadeltd/alpine-android-ndk:sdk-28` | [Info][android28] |
| Android 29 (10.0) | `docker pull fadeltd/alpine-android-ndk:sdk-29` | [Info][android29] |

## Use as Base Image

| API level         | Base Image                              |
|-------------------|-----------------------------------------|
| Android 28 (9.0)  | `FROM fadeltd/alpine-android-ndk:sdk-28` |
| Android 29 (10.0) | `FROM fadeltd/alpine-android-ndk:sdk-29` |

## Run container

| API level         | Command                                                |
|-------------------|--------------------------------------------------------|
| Android 28 (9.0)  | `docker run --rm -it fadeltd/alpine-android-ndk:sdk-28`|
| Android 29 (10.0) | `docker run --rm -it fadeltd/alpine-android-ndk:sdk-29`|

[docker]: https://hub.docker.com/r/fadeltd/alpine-android-ndk/
[docker-pulls]: https://img.shields.io/docker/pulls/fadeltd/alpine-android-ndk.svg "Docker Pulls"
[docker-stars]: https://img.shields.io/docker/stars/fadeltd/alpine-android-ndk-ruby.svg "Docker Stars"
[docker-base]: https://hub.docker.com/r/fadeltd/alpine-android-ndk-base/
[docker-base-pulls]: https://img.shields.io/docker/pulls/fadeltd/alpine-android-ndk-base.svg "Docker Pulls"
[docker-base-stars]: https://img.shields.io/docker/stars/fadeltd/alpine-android-ndk-base.svg "Docker Stars"

[android28]: https://github.com/fadeltd/alpine-android-ndk/tree/master/android-28
[android29]: https://github.com/fadeltd/alpine-android-ndk/tree/master/android-29
