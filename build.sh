#!/bin/bash

PROXY=""
IMAGE="xfce:base"
DOCKERFILE="Dockerfile.base"

for arg in "$@"; do
    case $arg in
        --proxy=*)
            PROXY="${arg#*=}"
            shift
            ;;
        --image=*)
            IMAGE="${arg#*=}"
            shift
            ;;
        --dockerfile=*)
	    DOCKERFILE="${arg#*=}"
	    shift
	    ;;
        *)
            echo "Unknown option: $arg"
            exit 1
            ;;
    esac
done


docker build \
     	-f "$DOCKERFILE" \
	-t "$IMAGE" \
	--build-arg PROXY="$PROXY" .
