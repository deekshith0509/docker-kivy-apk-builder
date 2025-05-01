FROM ubuntu:20.04
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV ANDROID_SDK_ROOT=/root/.buildozer/android/platform/android-sdk
ENV PATH=$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/platform-tools:$PATH
ENV BUILD_WITHOUT_INTERACTIVE=1
ENV PYTHONUNBUFFERED=1
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-virtualenv \
    python3-dev \
    git \
    zip \
    unzip \
    curl \
    wget \
    openjdk-17-jdk \
    build-essential \
    libsqlite3-dev \
    sqlite3 \
    libbz2-dev \
    zlib1g-dev \
    libssl-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libgdbm-dev \
    libdb5.3-dev \
    libexpat1-dev \
    liblzma-dev \
    libffi-dev \
    libtool \
    pkg-config \
    libgl1 \
    libgles2-mesa \
    libgl1-mesa-dev \
    autoconf \
    automake \
    libtool \
    libltdl-dev \
    m4 \
    gettext \
    texinfo \
    cmake \
    ninja-build \
    clang \
    lld \
    ccache \
    libstdc++6 \
    g++ \
    bash-completion \
    && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN pip install --upgrade pip==23.0.1 setuptools==68.0.0 wheel==0.41.0 Cython==0.29.36 importlib-metadata==4.13.0 virtualenv==20.24.6
RUN pip install buildozer==1.5.0
RUN mkdir -p ~/.android && echo "24333f8a63b6825ea9c5514f83c2829b004d1fe" > ~/.android/repositories.cfg
RUN mkdir -p $ANDROID_SDK_ROOT && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/android-tools.zip && \
    unzip -q /tmp/android-tools.zip -d /tmp/cmdline-tools && \
    mkdir -p $ANDROID_SDK_ROOT/cmdline-tools && \
    mv /tmp/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest && \
    rm -rf /tmp/android-tools.zip /tmp/cmdline-tools
RUN yes | sdkmanager --sdk_root=$ANDROID_SDK_ROOT --licenses
RUN sdkmanager --sdk_root=$ANDROID_SDK_ROOT \
    "platform-tools" \
    "platforms;android-33" \
    "build-tools;33.0.2" \
    "ndk;25.2.9519653" \
    "cmake;3.22.1" \
    "ndk-bundle"
# Fix Buildozer's expected path for sdkmanager
RUN mkdir -p $ANDROID_SDK_ROOT/tools/bin && \
    ln -s $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/sdkmanager $ANDROID_SDK_ROOT/tools/bin/sdkmanager && \
    ln -s $ANDROID_SDK_ROOT/cmdline-tools/latest/bin/avdmanager $ANDROID_SDK_ROOT/tools/bin/avdmanager
WORKDIR /app
# Simple fix: Create the bin directory before running buildozer
CMD ["sh", "-c", "mkdir -p bin && echo y | buildozer -v android debug"]
