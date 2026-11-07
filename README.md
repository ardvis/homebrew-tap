# Ardvis Homebrew tap

The Homebrew cask for Cleave, Ardvis's Mac app. It needs an Apple silicon Mac
on macOS 27 or later.

| Cask | Contents |
| --- | --- |
| `cleave` | Cleave, its command-line helper, and Cleave Node, the mesh host and Screen Sharing proxy it registers as a login item |

## Install

```sh
brew trust --tap ardvis/tap
brew tap ardvis/tap
brew install --cask cleave
```

Trust the tap first: Homebrew refuses casks from an untrusted tap.

## Release assets

This repository's releases hold the signed, notarized archives the cask
downloads, under `cleave-v<version>` tags: `cleave-macos-arm64.tar.gz`, its
`.sha256`, and an SPDX SBOM. Older `ardcode-v`, `ardterm-v` and `ardnode-v`
releases belong to retired apps.

`.github/workflows/release-attestation.yml` attests Cleave's archives on the
release event, and Cleave's release waits for and verifies that attestation.

Cleave's release writes its cask and assets here, publishing the cask after
the assets. The cask's version and checksum are generated from the release
template; never hand-edit them.
