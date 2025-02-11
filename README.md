# Container Demo

A demonstration project showing Docker container optimization techniques with a simple Go web server.

## Project Structure

```sh
.
├── Dockerfile.basic         # Basic Docker build
├── Dockerfile.basic.pinned  # Basic build with pinned base image
├── Dockerfile.cache.optimized # Build with layer caching optimization
├── Dockerfile.slim         # Slim build using alpine base
├── Dockerfile.slim.multi   # Multi-stage build for smallest image
└── src/
    ├── main.go            # Simple Go web server
    ├── go.mod
    └── go.sum
```

## Features

- Simple Go web server using Gin framework (Includes large unused dependencies to highlight layer caching)
- Multiple Dockerfile examples demonstrating:
  - Basic container builds
  - Image digest pinning
  - Layer caching optimization
  - Slim container builds
  - Multi-stage builds

## Prerequisites

- Docker
- Make (for running demos)
- `pv` Pipe Viewer (used by the demo)

## Quick Start

### MacOS

```bash
➜  brew bundle
==> Auto-updating Homebrew...
Adjust how often this is run with HOMEBREW_AUTO_UPDATE_SECS or disable with
HOMEBREW_NO_AUTO_UPDATE. Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).

Using pv
Homebrew Bundle complete! 1 Brewfile dependency now installed.
➜  make
```

To run the demo.

```bash
make
```

## ⚠️ Warning

This demo includes cleanup commands that:

1. Remove all Docker images tagged with `container-demo*`
2. Clear the global Docker build cache

These operations are performed to demonstrate layer caching from a clean slate. Be aware that:
- The build cache cleanup affects **all** projects on your system, not just this demo
- Subsequent builds of other projects may take longer until their cache is rebuilt
- Any existing `container-demo*` images will be deleted

If you want to preserve your build cache, remove the cleanup commands from [`demo.sh`](demo.sh).

```bash
# These commands in demo.sh clear your environment
docker rmi $(docker images "container-demo*" -q) 2>/dev/null || true
docker builder prune -f
```

## Build Options

- Basic build:

```bash
docker build -t container-demo-basic -f Dockerfile.basic .
```

- Cache-optimized build:

```bash
docker build -t container-demo-cache-optimized -f Dockerfile.cache.optimized .
```

- Slim build:

```bash
docker build -t container-demo-slim -f Dockerfile.slim .
```

- Multi-stage slim build:

```bash
docker build -t container-demo-slim-multi -f Dockerfile.slim.multi .
```

## Running the Container

After building, run the container:

```bash
docker run -p 8080:8080 <image-name>
```

The server will be available at `http://localhost:8080`
