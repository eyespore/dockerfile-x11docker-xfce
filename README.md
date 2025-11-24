# About this repo

This repository is a maintained and extended fork of **x11docker/xfce**. Since the upstream project no longer maintains standalone desktop environment images, this repo provides an updated and more flexible version of the XFCE Docker image.

Key highlights:

- **Multiple base images**: Supports Debian and Raspberry Pi OS (to improve hardware compatibility on Raspberry Pi devices), with more variants planned.
- **Two-stage Dockerfile design**:
   The first stage provides a minimal XFCE base image (most of them comes from x11docker/xfce), and the second stage offers preinstalled software for a convenient **out-of-the-box desktop experience**.
- **XFCE desktop in Docker**:
   Easily run a full XFCE environment inside Docker.
- **Works with x11docker**:
   Designed to be used with [x11docker](https://github.com/mviereck/x11docker) for running GUI applications and complete desktop sessions securely.

If you have questions about how to run GUI applications with x11docker, please refer to the **original project's documentation**, which remains the best source for usage and troubleshooting guidance.

# How to build

This project uses a two-stage Dockerfile structure. To build a complete image, you will typically use **two Dockerfiles**:

## **1. `Dockerfile.base` — Base Image Builder**

- Builds the minimal XFCE environment with only the essential desktop components.
- This image can be used as-is.
- For a more **out-of-the-box (OOTB)** experience, you can optionally build an additional layer that includes preinstalled software.

## **2. `Dockerfile.OS.VERSION` — Second-Stage Image (Preinstalled Software)**

- Extends the base image by installing additional packages.
- The `OS` and `VERSION` parts **must match** the base image you selected in `Dockerfile.base`.
   For example, if the base image uses *Raspberry Pi OS Bookworm*, the second-stage Dockerfile must also be built for the same OS variant.
- Different variants may install different software sets, so choose the one that fits your environment.

### **Example**

```
docker build -t xfce:base-v1.0 -f Dockerfile.base .
docker build -t xfce:raspberrypi-bookworm-v1.0 -f Dockerfile.raspberrypi-bookworm-v1.0 .
```

# How to run

## Setup using preset scripts

This project provides helper scripts to simplify launching your built images.
 These scripts can be found in the `scripts/` directory.

For example:

- **`launch-xfce`** — A script that includes all recommended options for running an XFCE desktop container.

⚠ **Important:**
 Be sure to update the image name inside the script to match the image you have built. Your local tags may differ from the defaults provided here.

## Command examples

 - Single application: `x11docker x11docker/xfce thunar`
 - Full desktop: `x11docker --desktop x11docker/xfce`

# Extend the base image

If you want to add your own applications or customize the environment, you can extend the image by modifying or creating a **second-stage Dockerfile**. This layer builds on top of the base image and allows you to install additional packages or apply further configuration.

Example:

```
# Extend the base XFCE image you built earlier
FROM xfce:base-v1.0

# Install additional applications
RUN apt-get update && \
    apt-get install -y midori
```

You may either:

- **Modify one of the existing `Dockerfile.OS.VERSION` files**, or
- **Create a new second-stage Dockerfile** if you need a custom variant.

This approach keeps your base image clean while giving you full flexibility to add the features you need.

 # Screenshot

 XFCE desktop in an Xnest window running with x11docker:

 ![screenshot](https://raw.githubusercontent.com/mviereck/x11docker/screenshots/screenshot-xfce.png "XFCE desktop running in Xephyr window using x11docker")

