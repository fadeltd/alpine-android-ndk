FROM fadeltd/alpine-android-ndk-ruby-base
LABEL description="Alpine Android NDK with Ruby 2.7.0 and SDK Tools 29"

ARG BUILD_TOOLS="29.0.3"
ARG TARGET_SDK="29"

ENV PATH=$PATH:$ANDROID_HOME/build-tools/${BUILD_TOOLS}

# Install SDK Packages
RUN yes | sdkmanager \
        "build-tools;${BUILD_TOOLS}" \
        "platforms;android-${TARGET_SDK}"
