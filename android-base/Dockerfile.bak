# extract libgcc from the same base image than the one used to build glibc
# (see https://github.com/sgerrand/docker-glibc-builder/blob/master/Dockerfile)
# ARG UBUNTU_VERSION="19.0.4"
# ARG GLIBC_IMAGE=ubuntu:${UBUNTU_VERSION}

ARG JAVA_MAJOR_VERSION="8"
ARG JAVA_MINOR_VERSION="212"
ARG JAVA_VERSION="${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}"

# FROM ${ALPINE_GLIBC_IMAGE} as libgcc
# RUN chmod +x /lib/x86_64-linux-gnu/libz.so.1.2.11

FROM fadeltd/openjdk:8-alpine3.11
LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"
LABEL description="Android NDK Base"

ARG SDK_TOOLS="4333796"
ARG CMAKE_VERSION="3.6.4111459"
ARG NDK_VERSION="21.0.6113669"

ARG GLIBC_VERSION="2.30-r0"
ARG GLIBC_REPO="https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}"
ARG GLIBC_PKGS="glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk glibc-i18n-${GLIBC_VERSION}.apk"

ENV ANDROID_HOME "/opt/android/sdk"
ENV ANDROID_NDK_HOME "$ANDROID_HOME/ndk/${NDK_VERSION}"
ENV PATH=$PATH:$ANDROID_HOME/cmake/${CMAKE_VERSION}/bin/:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

# Add the extra libs
# COPY --from=libgcc /lib/x86_64-linux-gnu/libgcc_s.so.1 /lib/x86_64-linux-gnu/libz.so.1.2.11 /usr/glibc-compat/lib/

# Install required dependencies
RUN apk add --no-cache bash git unzip wget && \
    wget -q "https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub" -O /etc/apk/keys/sgerrand.rsa.pub && \
    for pkg in "${GLIBC_PKGS}"; do \
        wget -q "${GLIBC_REPO}/${pkg}" -O "/tmp/${pkg}"; \
        apk add --no-cache "/tmp/${pkg}"; \
    done && \
    apk add --virtual .rundeps $runDeps && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

RUN wget "https://mirrors.ocf.berkeley.edu/archlinux/core/os/x86_64/zlib-1:1.2.11-4-x86_64.pkg.tar.xz" -O /tmp/libz.tar.xz \
    && mkdir -p /tmp/libz \
    && tar -xf /tmp/libz.tar.xz -C /tmp/libz \
    && cp /tmp/libz/usr/lib/libz.so.1.2.11 /usr/glibc-compat/lib \
    && /usr/glibc-compat/sbin/ldconfig \
    && rm -rf /tmp/libz /tmp/libz.tar.xz

# Download and extract Android Tools
RUN wget -q "http://dl.google.com/android/repository/sdk-tools-linux-${SDK_TOOLS}.zip" -O /tmp/tools.zip && \
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

# Install NDK & CMAKE Packages
RUN yes | sdkmanager \
        "cmake;${CMAKE_VERSION}" \
        "ndk;${NDK_VERSION}" >/dev/null

RUN ls -l $ANDROID_NDK_HOME/build && \
    ls -l $ANDROID_NDK_HOME/sources/ && \
    ls -l $ANDROID_NDK_HOME/sources/cxx-stl && \
    ls -l $ANDROID_NDK_HOME/platforms/ && \
    ls -l $ANDROID_NDK_HOME/prebuilt && \
    ls -l $ANDROID_NDK_HOME/toolchains/

# Delete unnecessary NDK Packages
RUN rm -rf  \
        $ANDROID_NDK_HOME/build/core/toolchains/mips* \
        $ANDROID_NDK_HOME/sources/cxx-stl/gnu-libstdc++ \
        $ANDROID_NDK_HOME/sources/cxx-stl/gnu-libstdc++/4.9/libs/mips* \
        $ANDROID_NDK_HOME/sources/cxx-stl/stlport \
        $ANDROID_NDK_HOME/sources/cxx-stl/llvm-libc++/libs/mips* \
        $ANDROID_NDK_HOME/sources/cxx-stl/llvm-libc++/test \
        $ANDROID_NDK_HOME/platforms/android-16 \
        $ANDROID_NDK_HOME/prebuilt/android-mips* \
        $ANDROID_NDK_HOME/toolchains/mips \
        $ANDROID_NDK_HOME/simpleperf \
    && sdkmanager --list | sed -e '/Available Packages/q'

WORKDIR /home/android
