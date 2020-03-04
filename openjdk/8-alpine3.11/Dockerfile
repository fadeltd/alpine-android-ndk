ARG ALPINE_VERSION="3.11.3"
ARG ALPINE_IMAGE=alpine:${ALPINE_VERSION}

FROM ${ALPINE_IMAGE}

LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"
LABEL description="Alpine 3.11.3 Open JDK 8u242"

# https://pkgs.alpinelinux.org/package/v3.11/community/x86/openjdk8
# Using OpenJDK 8 provided by IcedTea from alpine pkgs
ARG JAVA_MAJOR_VERSION="8"
ARG JAVA_MINOR_VERSION="242"
ARG JAVA_BUILD_VERSION="08"
ARG JAVA_VERSION="${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}"
ARG JAVA_ALPINE_VERSION="${JAVA_MAJOR_VERSION}.${JAVA_MINOR_VERSION}.${JAVA_BUILD_VERSION}-r0"
# ARG JAVA_JDK="java-1.8-openjdk"
# ARG JAVA_DEFAULT_JVM_PATH=/usr/lib/jvm/${JAVA_JDK}
ARG JAVA_DEFAULT_JVM_PATH="/usr/lib/jvm/default-jvm"

ENV LANG C.UTF-8
ENV JAVA_VERSION "${JAVA_VERSION}"
ENV JAVA_HOME "/usr/lib/jvm/java-1.${JAVA_MAJOR_VERSION}.0_${JAVA_MINOR_VERSION}"
ENV PATH "$PATH:${JAVA_HOME}/bin:${JAVA_HOME}/jre/bin"

RUN set -eux && \
	apk add --no-cache openjdk8="${JAVA_ALPINE_VERSION}" && \
	mv "${JAVA_DEFAULT_JVM_PATH}" "${JAVA_HOME}"; \
	# Java smoke test
	which java; \
	java -version; \
	which javac; \
	javac -version
