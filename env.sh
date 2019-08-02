#!/bin/bash

if [ -z ${PROJECT_NAME+x} ]; then
    PROJECT_NAME="projcpp"
fi

if [ -z ${BUILD_DIR+x} ]; then
    BUILD_DIR="$HOME/tmp/${PROJECT_NAME}_build"
fi

if [ -z ${OUTPUT_DIR+x} ]; then
    OUTPUT_DIR="$HOME/tmp/${PROJECT_NAME}"
fi
