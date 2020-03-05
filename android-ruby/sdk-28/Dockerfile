FROM fadeltd/alpine-android-ndk-ruby-base
LABEL description="Alpine Android NDK with Ruby 2.7.0 and SDK Tools 28"
LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"

ARG BUILD_TOOLS="28.0.3"
ARG TARGET_SDK="28"

ENV PATH=$PATH:$ANDROID_HOME/build-tools/${BUILD_TOOLS}

# Install SDK Packages
RUN yes | sdkmanager \
        "build-tools;${BUILD_TOOLS}" \
        "platforms;android-${TARGET_SDK}"
