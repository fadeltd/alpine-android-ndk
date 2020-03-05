FROM fadeltd/android-bl-base
LABEL description="Android BL Image with NDK and SDK 29"
LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"

ARG BUILD_TOOLS="29.0.3"
ARG TARGET_SDK="29"

ENV PATH=$PATH:$ANDROID_HOME/build-tools/${BUILD_TOOLS}

# Install SDK Packages
RUN yes | sdkmanager \
        "build-tools;${BUILD_TOOLS}" \
        "platforms;android-${TARGET_SDK}"
