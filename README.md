# Ardvis Homebrew tap

Homebrew casks for the Ardvis macOS apps. Each needs an Apple silicon Mac on
macOS 27 or later.

| Cask | Contents |
| --- | --- |
| `ardcode` | Ardcode app and the code exploration CLI |
| `ardterm` | Ardterm terminal app |
| `ardnode` | Ardnode mesh host helper and Screen Sharing proxy |

## Install

```sh
brew trust --tap ardvis/tap
brew tap ardvis/tap
brew install --cask ardcode     # or ardterm, or ardnode
```

Trust the tap first. Homebrew refuses casks from an untrusted tap, and it loads
a cask dependency by bare name even for an explicit `ardvis/tap/ardcode`.
Ardcode and Ardterm declare `depends_on cask: "ardnode"`, so without the trust
step the install fails on the Ardnode dependency. Homebrew resolves a cask
dependency only against an installed tap, which is why one tap holds all three
casks and why you tap before installing.

## Moving from the per-product taps

Casks once came from `ardvis/ardcode-dist`, `ardvis/ardterm-dist` and
`ardvis/ardnode-dist`. To switch:

```sh
brew tap                        # list the Ardvis taps you have
brew untap ardvis/ardcode-dist  # and ardvis/ardterm-dist, ardvis/ardnode-dist
brew trust --tap ardvis/tap
brew tap ardvis/tap
brew upgrade --cask ardcode     # or ardterm; reinstalls from this tap
```

Untapping keeps the app and its data, and `brew upgrade` reinstalls the cask
from this tap at the published version. Trust entries for the old taps can
stay.

## Release assets

This repository's releases hold the signed, notarized archives the casks
download, under product-prefixed tags (`ardcode-v<version>`,
`ardterm-v<version>`, `ardnode-v<version>`).

| Product | Assets |
| --- | --- |
| Ardcode | `ardcode-macos-arm64.tar.gz`, its `.sha256`, an SPDX SBOM |
| Ardterm, Ardnode | The archive, `SHA256SUMS`, the resolved `Package.resolved`, `release.json` |

`.github/workflows/release-attestation.yml` attests Ardcode's archives on the
release event, and Ardcode's release waits for and verifies that attestation.
Releases from before the move stay in the per-product `-dist` repositories,
which no release path uses any more.

Each product's release script writes its cask and assets here, publishing the
cask after the assets. Casks, versions and checksums are generated from the
product release templates; never hand-edit them.
