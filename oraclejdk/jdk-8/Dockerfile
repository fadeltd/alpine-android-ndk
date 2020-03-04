ARG ALPINE_VERSION="3.11.3"
ARG ALPINE_IMAGE=alpine:${ALPINE_VERSION}

FROM ${ALPINE_IMAGE}

LABEL maintainer="Fadel Trivandi Dipantara <fadeltd@hotmail.com>"
LABEL description="Alpine 3.11.3 Oracle JDK 8u241"

# https://www.oracle.com/java/technologies/javase/javase-jdk8-downloads.html
# Java™ Platform Standard Edition Development Kit (JDK™).
# The JDK is a development environment for building applications, applets, and components using the Java programming language.
# The JDK includes tools useful for developing and testing programs written in the Java programming language and running on the Java platform.
ARG JAVA_MAJOR_VERSION="8"
ARG JAVA_MINOR_VERSION="241"
ARG JAVA_BUILD_VERSION="b07"
ARG JAVA_VERSION="${JAVA_MAJOR_VERSION}u${JAVA_MINOR_VERSION}"
ARG JAVA_ARCH="linux-x64"
ARG JAVA_ORACLE_AUTH="1f5b5a70bf22433b84d0e960903adac8"
ARG JAVA_PACKAGE="jdk"
ARG JAVA_BASE_URL="https://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION}-${JAVA_BUILD_VERSION}/${JAVA_ORACLE_AUTH}"
ARG JAVA_ASSET="${JAVA_PACKAGE}-${JAVA_VERSION}-${JAVA_ARCH}.tar.gz"
ARG JAVA_ASSET_URL="${JAVA_BASE_URL}/${JAVA_ASSET}"
ARG JAVA_CHECKSUM="https://www.oracle.com/webfolder/s/digest/${JAVA_VERSION}checksum.html"
ARG JAVA_TMP="/tmp/oracle-jdk.tgz"

ARG JAVA_JVM_PATH="/usr/lib/jvm"
ARG JAVA_JDK="java-1.8-oracle"
ENV JAVA_HOME "${JAVA_JVM_PATH}/${JAVA_JDK}"
ENV PATH $PATH:$JAVA_HOME/bin

ARG GLIBC_VERSION="2.30-r0"
ARG GLIBC_REPO="https://github.com/sgerrand/alpine-pkg-glibc"
ARG GLIBC_DOWNLOAD="${GLIBC_REPO}/releases/download/${GLIBC_VERSION}"
ARG GLIBC_PACKAGES="glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk glibc-i18n-${GLIBC_VERSION}.apk"
ARG GLIBC_PATH="/usr/glibc-compat"

RUN set -eux; \
	apk -U upgrade; \
    apk add --no-cache --virtual .java-deps libstdc++ curl; \
# Required glibc dependencies
	for pkg in ${GLIBC_PACKAGES}; do wget -O "/tmp/${pkg}" "${GLIBC_DOWNLOAD}/${pkg}"; done && \
	apk add --allow-untrusted /tmp/*.apk && \
    ( ${GLIBC_PATH}/bin/localedef --force --inputfile POSIX --charmap UTF-8 C.UTF-8 || true ); \
    echo "export LANG=C.UTF-8" > /etc/profile.d/locale.sh; \
    ${GLIBC_PATH}/sbin/ldconfig /lib ${GLIBC_PATH}/lib; \
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf; \
# Install java from oracle
    wget -O "${JAVA_TMP}" "--header=Cookie: oraclelicense=accept-securebackup-cookie" "${JAVA_ASSET_URL}" && \
	JAVA_PACKAGE_SHA256=$(curl -sSL "${JAVA_CHECKSUM}" | grep -E "${JAVA_ASSET}" | grep -Eo '(sha256: )[^<]+' | cut -d: -f2 | xargs) && \
    echo "${JAVA_PACKAGE_SHA256}  ${JAVA_TMP}" | sha256sum -c; \
	mkdir -p "${JAVA_HOME}"; \
    tar --extract --file "${JAVA_TMP}" --directory "${JAVA_HOME}" --strip-components 1; \
	ln -s "$JAVA_HOME/bin/"* "/usr/bin/"; \
# Clean up
	apk del glibc-i18n; \
	apk del --no-network .java-deps; \
	# find ${JAVA_HOME} -maxdepth 1 -mindepth 1 | grep -v jre | xargs rm -rf && \
	rm -rf \
		/tmp/* /var/cache/apk/*; \
		# $JAVA_HOME/jre/bin/javaws \
		# $JAVA_HOME/jre/bin/jjs \
		# $JAVA_HOME/jre/bin/orbd \
		# $JAVA_HOME/jre/bin/pack200 \
		# $JAVA_HOME/jre/bin/policytool \
		# $JAVA_HOME/jre/bin/rmid \
		# $JAVA_HOME/jre/bin/rmiregistry \
		# $JAVA_HOME/jre/bin/servertool \
		# $JAVA_HOME/jre/bin/tnameserv \
		# $JAVA_HOME/jre/bin/unpack200 \
		# $JAVA_HOME/jre/lib/*javafx* \
		# $JAVA_HOME/jre/lib/*jfx* \
		# $JAVA_HOME/jre/lib/amd64/libdecora_sse.so \
		# $JAVA_HOME/jre/lib/amd64/libfxplugins.so \
		# $JAVA_HOME/jre/lib/amd64/libglass.so \
		# $JAVA_HOME/jre/lib/amd64/libgstreamer-lite.so \
		# $JAVA_HOME/jre/lib/amd64/libjavafx*.so \
		# $JAVA_HOME/jre/lib/amd64/libjfx*.so \
		# $JAVA_HOME/jre/lib/deploy* \
		# $JAVA_HOME/jre/lib/ext/jfxrt.jar \
		# $JAVA_HOME/jre/lib/ext/nashorn.jar \
		# $JAVA_HOME/jre/lib/javaws.jar \
		# $JAVA_HOME/jre/lib/jfr.jar \
		# $JAVA_HOME/jre/lib/plugin.jar \
# Java smoke test
	which java; \
	java -version; \
	which javac; \
	javac -version

# https://docs.oracle.com/javase/10/tools/jshell.htm
# https://docs.oracle.com/javase/10/jshell/
# https://en.wikipedia.org/wiki/JShell
CMD ["jshell"]
