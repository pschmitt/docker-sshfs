# Agent notes

This repository builds a container image that mounts directories over SSH for
CoreOS Container Linux.

- Build with `docker build` and validate mounts against an isolated SSH test
  server using a throwaway key. Do not put real host names, keys, or share
  paths in examples.
- The push workflow builds the image. Do not change publication settings
  without an explicit request.
- Before changing CI, check for reusable workflows or actions in
  [ci-workflows](https://github.com/pschmitt/ci-workflows) and preserve the
  workflow's current behavior and checks.
