#!/bin/bash

if [ -z ${PROJECT_NAME+x} ]; then
    echo 'Environment variable PROJECT_NAME not set'
    exit 1
fi

if [ -z ${BUILD_DIR+x} ]; then
    echo 'Environment variable BUILD_DIR not set'
    exit 1
fi

if [ -z ${OUTPUT_DIR+x} ]; then
    echo 'Environment variable OUTPUT_DIR not set'
    exit 1
fi

echo "Creating build directory: $BUILD_DIR"
mkdir -p $BUILD_DIR

echo "Creating output directory: $OUTPUT_DIR"
mkdir -p $OUTPUT_DIR
