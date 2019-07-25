ARG alpine_version=3.10.1
ARG alpine_glibc_version=2.29-r0

# extract libgcc_s from the same base image than the one used to build glibc (see https://github.com/sgerrand/docker-glibc-builder/blob/master/Dockerfile)
ARG alpine_pkg_glibc_image=ubuntu:18.04

FROM ${alpine_pkg_glibc_image} as libgcc
RUN chmod +x /lib/x86_64-linux-gnu/libz.so.1.2.11

FROM openjdk:8-alpine
LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"
LABEL description="Android SDK 28 & NDK"

ARG SDK_TOOLS="4333796"
ARG GLIBC_VERSION="2.29-r0"
ARG BUILD_TOOLS="28.0.3"
ARG TARGET_SDK="28"
ARG CMAKE_VERSION="3.6.4111459"

ENV ANDROID_HOME "/opt/android-sdk-linux"
ENV NDK_HOME $ANDROID_HOME/ndk-bundle
ENV PATH=$PATH:$ANDROID_HOME/cmake/3.6.4111459/bin/:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Add the extra libs
COPY --from=libgcc /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libz.so.1.2.11 /usr/glibc-compat/lib/

# Install required dependencies
RUN apk add --no-cache bash git unzip wget && \
    wget -q https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub && \
    wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk -O /tmp/glibc.apk && \
    wget -q https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk -O /tmp/glibc-bin.apk && \
    apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk && \
    apk add --virtual .rundeps $runDeps && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

RUN wget "https://ind.mirror.pkgbuild.com/core/os/x86_64/zlib-1:1.2.11-3-x86_64.pkg.tar.xz" -O /tmp/libz.tar.xz \
    && mkdir -p /tmp/libz \
    && tar -xf /tmp/libz.tar.xz -C /tmp/libz \
    && cp /tmp/libz/usr/lib/libz.so.1.2.11 /usr/glibc-compat/lib \
    && /usr/glibc-compat/sbin/ldconfig \
    && rm -rf /tmp/libz /tmp/libz.tar.xz

# Download and extract Android Tools
RUN wget -q http://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS}.zip -O /tmp/tools.zip && \
    mkdir -p ${ANDROID_HOME} && \
    unzip -qq /tmp/tools.zip -d ${ANDROID_HOME} && \
    rm -v /tmp/tools.zip

# Install SDK Packages
RUN mkdir -p ~/.android/ && touch ~/.android/repositories.cfg && \
    yes | sdkmanager "--licenses" && \
    sdkmanager "--update" && \
    sdkmanager "platform-tools" \
        "extras;android;m2repository" \
        "extras;google;m2repository" \
        "extras;google;instantapps"

# Install SDK Packages
RUN yes | sdkmanager \
        "build-tools;${BUILD_TOOLS}" \
        "platforms;android-${TARGET_SDK}"

# Install NDK & CMAKE Packages
RUN yes | sdkmanager \
        "cmake;${CMAKE_VERSION}" \
        "ndk-bundle" >/dev/null

# Delete unnecessary NDK Packages
RUN rm -rf  \
        # Delete simpleperf tool
        $NDK_HOME/simpleperf \
        # Delete STL version we don't care about
        $NDK_HOME/sources/cxx-stl/stlport \
        $NDK_HOME/sources/cxx-stl/gnu-libstdc++ \
        # Delete unused prebuild images
        $NDK_HOME/prebuilt/android-mips* \
        # Delete obsolete Android platforms
        $NDK_HOME/platforms/android-9 \
        $NDK_HOME/platforms/android-12 \
        $NDK_HOME/platforms/android-13 \
        $NDK_HOME/platforms/android-15 \
        $NDK_HOME/platforms/android-16 \
        # Delete unused platform sources
        $NDK_HOME/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips* \
        $NDK_HOME/sources/cxx-stl/llvm-libc++/libs/mips* \
        # Delete LLVM STL tests
        $NDK_HOME/sources/cxx-stl/llvm-libc++/test \
        # Delete unused toolchains
        $NDK_HOME/toolchains/mips \
        $NDK_HOME/build/core/toolchains/mips* \
    && sdkmanager --list | sed -e '/Available Packages/q'

WORKDIR /home/android
