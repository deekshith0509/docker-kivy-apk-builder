# docker-kivy-apk-builder

A Docker-based Android APK builder for Python/Kivy applications using Buildozer. This containerized setup eliminates system dependency issues and offers a consistent, reproducible Android build environment.

---

## ✅ Features

- Ubuntu 20.04 with full Android SDK + NDK setup
- Pre-installed Buildozer 1.5.0
- OpenJDK 17, Python 3, pip, Cython, setuptools
- Supports ARM64-v8a and armeabi-v7a builds
- Output APK saved directly to the **host app directory**
- One-line Docker run—clean and portable
- Non-interactive build with license auto-acceptance

---

## 🐳 Docker Usage

### 1. Clone This Repository

```bash

git clone https://github.com/YOUR_USERNAME/docker-kivy-apk-builder.git
cd docker-kivy-apk-builder
```

### 2. Build the Docker Image
```
docker build -t kivy-apk .
```


### 3. Prepare Your Kivy Project

Make sure your project directory (outside this repo) contains:
```
main.py
buildozer.spec
```
Example:
```
my-kivy-app/
├── main.py
├── buildozer.spec
```

### 4. Run APK Build

Run this inside your project directory:
```
docker run --rm -v $(pwd):/app kivy-apk
```
## 📦 Output

The resulting .apk will be available in:
```
./bin/yourapp-debug.apk
```

The output is saved in your host project folder, not inside the container.
## 🧹 Clean Up

After building, delete the temporary .buildozer/ directory:
```
rm -rf .buildozer/
```
This step is recommended to keep your project clean.
## 🧱 Stack Details
```
    Ubuntu 20.04

    Python 3.x, pip 23.0.1

    Buildozer 1.5.0

    Cython 0.29.36

    Android SDK Platform 33, Build-tools 33.0.2

    Android NDK 25.2

    CMake 3.22

    OpenJDK 17
```
