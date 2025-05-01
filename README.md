
# Docker-based Android APK Builder for Python/Kivy Applications using Buildozer

This Docker image provides a containerized setup to build Android APKs for Python/Kivy applications. The environment is preconfigured with all the necessary tools to compile and package Android applications, using **Buildozer** and the **Android SDK**.

It removes the hassle of dealing with system dependency issues and provides a consistent, reproducible Android build environment for Python/Kivy applications. This setup is perfect for those who want a clean, isolated environment for building Android apps with Python/Kivy.

## ✅ Features

- **Pre-configured Android SDK & NDK**: Full Android SDK and NDK setup, including platform tools and build tools, to easily build and package APKs.
- **Buildozer 1.5.0**: Pre-installed Buildozer version for automatic APK building.
- **OpenJDK 17**: Java 17 is included, as it’s required for Android SDK tools.
- **Python 3.x**: Python 3 with pip, setuptools, Cython, and virtualenv support.
- **Cross-platform Builds**: Supports both ARM64-v8a and armeabi-v7a builds for compatibility with a wide range of Android devices.
- **Output APK Saved to Host**: APK output is saved directly to your host machine, ensuring easy access and management.
- **Portable and Clean**: One-line Docker command to build, ensuring a clean and isolated build environment without interfering with the host system.
- **Non-Interactive**: Build is fully automated and non-interactive, with license acceptance preconfigured.
  
## 🐳 Docker Usage

### 1. Clone This Repository

First, clone the repository and navigate to the folder:

```bash
git clone https://github.com/deekshith0509/docker-kivy-apk-builder.git
cd docker-kivy-apk-builder
```

### 2. Build the Docker Image

Build the Docker image using the provided `Dockerfile`:

```bash
docker build -t kivy-apk .
```

This command will build the Docker image with all the necessary dependencies, such as Buildozer, OpenJDK 17, Android SDK/NDK, Python 3, and related build tools.

### 3. Prepare Your Kivy Project

Make sure your Kivy project directory contains the necessary files for Buildozer:

```
my-kivy-app/
├── main.py
├── buildozer.spec
```

### 4. Run APK Build

To build your APK, run the following command inside your project directory:

```bash
docker run --rm -v $(pwd):/app kivy-apk
```

This command mounts your project folder into the Docker container, runs the Buildozer process, and places the APK file in your host machine's `./bin` directory.

### 5. Retrieve the APK

Once the build completes, the resulting APK file will be available in your project directory, under:

```
./bin/yourapp-debug.apk
```

### 6. Clean Up

After building the APK, it's recommended to clean up the temporary Buildozer directory to keep your project clean:

```bash
rm -rf .buildozer/
```

## 🧱 Stack Details

This Docker image is based on the following components:

- **Base Image**: Ubuntu 20.04
- **Android SDK Platform**: 33
- **Android Build Tools**: 33.0.2
- **Android NDK**: 25.2.9519653
- **Android Command Line Tools**: Latest version (11076708)
- **CMake**: 3.22.1
- **Python**: 3.x
- **Buildozer**: 1.5.0
- **Cython**: 0.29.36
- **OpenJDK**: 17
- **Supported Architectures**: ARM64-v8a, armeabi-v7a
- **Pre-installed Packages**:
  - **Python**: `python3`, `pip`, `setuptools`, `wheel`, `virtualenv`, `Cython`
  - **Build Tools**: `make`, `cmake`, `ninja`, `clang`, `g++`, `ccache`, `pkg-config`, `libtool`
  - **SQLite**: `libsqlite3-dev`, `sqlite3`
  - **Compression**: `zlib1g-dev`, `libbz2-dev`, `liblzma-dev`
  - **SSL**: `libssl-dev`
  - **Networking**: `curl`, `wget`, `git`
  - **Android SDK Dependencies**: `platform-tools`, `ndk`, `cmake`, `build-tools`, etc.

## 💡 Environment Variables

- **JAVA_HOME**: `/usr/lib/jvm/java-17-openjdk-amd64` (points to the installed JDK).
- **ANDROID_SDK_ROOT**: `/root/.buildozer/android/platform/android-sdk` (the path to the Android SDK inside the container).
- **PATH**: Includes the Android SDK’s `cmdline-tools` and `platform-tools` for easy access to Android tools like `sdkmanager` and `adb`.
- **DEBIAN_FRONTEND**: Set to `noninteractive` to avoid interactive prompts during package installations.
- **PYTHONUNBUFFERED**: Ensures Python output is not buffered, useful for logs.
- **LANG/LC_ALL**: Set to `C.UTF-8` for consistent UTF-8 handling.

## 🧑‍💻 Buildozer Configuration

The image is preconfigured to use **Buildozer** for building the APKs. Buildozer relies on the `buildozer.spec` file to configure the build process.

Ensure your `buildozer.spec` file is properly configured for your Kivy project. Common configuration options include:

- **Package Name**: Set the package name of your app (`package.name`).
- **Version**: Set the version of your app (`version`).
- **Requirements**: Specify Python dependencies for the project (`requirements`).
- **Android Permissions**: Set the necessary permissions required for your app (`android.permissions`).
  
## 📝 Notes on Android SDK Setup

The Android SDK and NDK are preinstalled and configured in the Docker image. The `sdkmanager` is used to install necessary SDK packages. All licenses are auto-accepted during the build process.

If you need to install additional SDK or NDK components, you can use the following command within the container (the image includes the `sdkmanager` tool):

```bash
sdkmanager --sdk_root=$ANDROID_SDK_ROOT "platform-tools" "platforms;android-33" "build-tools;33.0.2" "ndk;25.2.9519653"
```

This command installs or updates specific SDK components.

## 📂 Dockerfile Details

The provided `Dockerfile` creates a Docker image with the following steps:

1. **Base Image**: Starts from the `ubuntu:20.04` image.
2. **Environment Variables**: Configures necessary environment variables such as `JAVA_HOME`, `ANDROID_SDK_ROOT`, and `PATH` for Android tools.
3. **Installing Dependencies**: Installs Python 3, Android SDK, NDK, build tools, and other required libraries using `apt-get` and `pip`.
4. **Android SDK Setup**: Downloads and unzips the Android command line tools and sets them up in the correct directory.
5. **Buildozer Installation**: Installs Buildozer for automatic APK building.
6. **SDK Configuration**: Sets up the SDK, installs necessary packages, and accepts SDK licenses automatically.
7. **SDK Tool Fix**: Fixes Buildozer's expected SDK path for compatibility with `sdkmanager` and `avdmanager`.
8. **Working Directory**: Sets the working directory to `/app`, where your Kivy project will be mounted.

## 🧹 Clean-Up Recommendations

It's recommended to clean up your Docker container and project folder regularly to keep the system tidy and reduce unnecessary space usage. Delete the `.buildozer/` folder after a build to remove temporary files.

```bash
rm -rf .buildozer/
```

## 💡 Troubleshooting

- **SDK Installation Errors**: If you encounter issues with the Android SDK installation, verify that your internet connection is stable and that the `sdkmanager` commands are working correctly.
- **Build Failures**: Check your `buildozer.spec` file for any misconfigurations, especially regarding package dependencies, permissions, and versions.
  
## 🎉 Contributions

Feel free to submit issues or pull requests if you have any suggestions or improvements for this project. Contributions are always welcome!

## 📅 Version Information

- **Buildozer**: 1.5.0
- **Android SDK**: Platform 33, Build-tools 33.0.2
- **NDK**: 25.2.9519653
- **OpenJDK**: 17
- **CMake**: 3.22.1
