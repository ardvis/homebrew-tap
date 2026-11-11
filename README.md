# Ardvis Homebrew tap

The Homebrew cask for Cleven, Ardvis's Mac app. It needs an Apple silicon Mac
on macOS 27 or later.

| Cask | Contents |
| --- | --- |
| `cleven` | Cleven, its command-line helper, and Cleven Node, the mesh host and Screen Sharing proxy it registers as a login item |

## Install

```sh
brew trust --tap ardvis/tap
brew tap ardvis/tap
brew install --cask cleven
```

Trust the tap first: Homebrew refuses casks from an untrusted tap.

## Release assets

This repository's releases hold the signed, notarized archives the cask
downloads, under `cleven-v<version>` tags: `cleven-macos-arm64.tar.gz`, its
`.sha256`, and an SPDX SBOM.

`.github/workflows/release-attestation.yml` attests Cleven's archives on the
release event, and Cleven's release waits for and verifies that attestation.

Cleven's release writes its cask and assets here, publishing the cask after
the assets. The cask's version and checksum are generated from the release
template; never hand-edit them.
