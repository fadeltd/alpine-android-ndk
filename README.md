# Alpine Android NDK

![Build and Publish Docker](https://github.com/fadeltd/alpine-android-ndk/workflows/Build%20and%20Publish%20Docker/badge.svg)

| Alpine OpenJDK8             | Alpine Android NDK Base             | Alpine Android NDK        |
|-----------------------------|-------------------------------------|---------------------------|
| [![openjdk-pulls]][openjdk] | [![docker-base-pulls]][docker-base] | [![docker-pulls]][docker] |
| [![openjdk-stars]][openjdk] | [![docker-base-stars]][docker-base] | [![docker-stars]][docker] |

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

[openjdk]: https://hub.docker.com/r/fadeltd/openjdk/
[openjdk-pulls]: https://img.shields.io/docker/pulls/fadeltd/openjdk.svg "Docker Pulls"
[openjdk-stars]: https://img.shields.io/docker/stars/fadeltd/openjdk.svg "Docker Pulls"

[docker]: https://hub.docker.com/r/fadeltd/alpine-android-ndk/
[docker-pulls]: https://img.shields.io/docker/pulls/fadeltd/alpine-android-ndk.svg "Docker Pulls"
[docker-stars]: https://img.shields.io/docker/stars/fadeltd/alpine-android-ndk.svg "Docker Stars"

[docker-base]: https://hub.docker.com/r/fadeltd/alpine-android-ndk-base/
[docker-base-pulls]: https://img.shields.io/docker/pulls/fadeltd/alpine-android-ndk-base.svg "Docker Pulls"
[docker-base-stars]: https://img.shields.io/docker/stars/fadeltd/alpine-android-ndk-base.svg "Docker Stars"

[android28]: https://github.com/fadeltd/alpine-android-ndk/tree/master/android-28
[android29]: https://github.com/fadeltd/alpine-android-ndk/tree/master/android-29
