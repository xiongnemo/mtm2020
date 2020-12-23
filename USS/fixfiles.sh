#!/bin/sh
echo "Fixing files"
LC_ALL=C find . -name '*[! -~]*' | xargs rm > /dev/null 2>&1

echo "Fixing directories"
LC_ALL=C find . -name '*[! -~]*' | xargs rmdir > /dev/null 2>&1
