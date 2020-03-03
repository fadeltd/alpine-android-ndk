FROM fadeltd/alpine-android-ndk-base
LABEL description="Alpine Android NDK with SDK Tools 28"

ARG BUILD_TOOLS="28.0.3"
ARG TARGET_SDK="28"

ENV PATH=$PATH:$ANDROID_HOME/build-tools/${BUILD_TOOLS}

# Install SDK Packages
RUN yes | sdkmanager \
        "build-tools;${BUILD_TOOLS}" \
        "platforms;android-${TARGET_SDK}"
