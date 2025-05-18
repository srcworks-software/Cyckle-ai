#!/bin/bash
set -e

echo "Building Docker image..."
docker build -t cyckle-build .

echo "Building wheel and repairing inside container..."
docker run --rm -v "$(pwd)/wheelhouse:/wheelhouse" cyckle-build bash -c "
    python3 setup.py bdist_wheel && \
    auditwheel repair dist/*.whl -w /wheelhouse
"

echo "Done! Your wheel should be in ./wheelhouse"