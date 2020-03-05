# extract libgcc from the same base image than the one used to build glibc
# (see https://github.com/sgerrand/docker-glibc-builder/blob/master/Dockerfile)

FROM fadeltd/openjdk:8-alpine3.11
LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"
LABEL description="Android NDK Base"

ARG SDK_TOOLS="4333796"
ARG CMAKE_VERSION="3.6.4111459"
ARG NDK_VERSION="21.0.6113669"

ENV ANDROID_HOME "/opt/android/sdk"
ENV ANDROID_NDK_HOME "$ANDROID_HOME/ndk/${NDK_VERSION}"
ENV PATH=$PATH:$ANDROID_HOME/cmake/${CMAKE_VERSION}/bin/:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

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

# RUN ls -l $ANDROID_NDK_HOME/build && \
#     ls -l $ANDROID_NDK_HOME/sources/ && \
#     ls -l $ANDROID_NDK_HOME/sources/cxx-stl && \
#     ls -l $ANDROID_NDK_HOME/platforms/ && \
#     ls -l $ANDROID_NDK_HOME/prebuilt && \
#     ls -l $ANDROID_NDK_HOME/toolchains/

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
