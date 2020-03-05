FROM fadeltd/alpine-android-ndk-ruby-base
LABEL description="Alpine Android NDK with Ruby, Git LFS, Firebase, Fastlane"
LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"

RUN apk --no-cache add \
    g++ \
    libstdc++ \
    bash \
    curl \
    git \
    make

# Git LFS
ARG GIT_LFS_VERSION="v2.10.0"
ARG GIT_LFS_REPO="https://github.com/github/git-lfs"
ARG GIT_LFS_DOWNLOAD="${GIT_LFS_REPO}/releases/download"
ARG GIT_LFS_ARCH="linux-amd64"
ARG GIT_LFS_PACKAGE="git-lfs"
ARG GIT_LFS_ASSET="${GIT_LFS_PACKAGE}-${GIT_LFS_ARCH}-${GIT_LFS_VERSION}.tar.gz"
ARG GIT_LFS_URL="${GIT_LFS_DOWNLOAD}/${GIT_LFS_VERSION}/${GIT_LFS_ASSET}"
ARG GIT_LFS_SHA="ec1513069f2679c4c95d9d7c54fdb4b9d7007cc568578a25e2b2ff30edd93cfd"
RUN set -eux; \
    wget -O /tmp/${GIT_LFS_ASSET} ${GIT_LFS_URL}; \
    echo "${GIT_LFS_SHA}  /tmp/${GIT_LFS_ASSET}" | sha256sum -c; \
    mkdir -p "/tmp/git-lfs"; \
    tar -C "/tmp/git-lfs" -xf "/tmp/${GIT_LFS_ASSET}" "git-lfs"; \
    mv /tmp/git-lfs/git-lfs /usr/local/bin/git-lfs; \
    # tar -C "/tmp/git-lfs" -xf "/tmp/${GIT_LFS_ASSET}" "install.sh"; \
    # /tmp/git-lfs/install.sh; \
    which git-lfs; \
    git-lfs --version; \
    rm -rf /tmp/*

# Firebase
RUN wget -O /tmp/firebase https://firebase.tools/bin/linux/latest \
    && chmod +xr /tmp/firebase \
    && mv /tmp/firebase /usr/local/bin/

# Fastlane
ARG FASTLANE_VERSION="2.142.0"
RUN apk --no-cache add --update curl-dev imagemagick && \
    gem install fastlane -N -v ${FASTLANE_VERSION} && \
    gem install badge;

# Bundler
# ARG BUNDLER_VERSION="1.17.3"
# RUN gem install bundler --default -v ${BUNDLER_VERSION}

# WORKDIR /home/android
# COPY Gemfile Gemfile.lock ./
# RUN bundle install
