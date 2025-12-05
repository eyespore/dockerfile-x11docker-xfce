#!/bin/bash
./build.sh --image=xfce:latest \
	--dockerfile=Dockerfile.raspberrypios-bookworm \
	--proxy=http://pc.pineclone.cc:9987
