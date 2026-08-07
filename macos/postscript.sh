#!/bin/bash
rtk init -g

npm config set min-release-age 7 --location=user
npm config set registry https://npm.flatt.tech --location=user
pnpm config set minimumReleaseAge 10080 --global
