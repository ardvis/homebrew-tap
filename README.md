# Ardvis Homebrew tap

Homebrew casks for the Ardvis macOS apps: Ardcode, Ardterm, and the Ardnode mesh
host helper.

## Install

```sh
brew trust --tap ardvis/tap
brew tap ardvis/tap
brew install --cask ardcode     # or ardterm, or ardnode
```

Trust the tap first. Homebrew refuses to load a cask from an untrusted tap, and
it loads a cask dependency by bare name even when you install with an explicit
`ardvis/tap/ardcode` reference. Ardterm and Ardcode declare
`depends_on cask: "ardnode"`, so without `brew trust --tap ardvis/tap` the
install fails while loading the Ardnode dependency.

Tapping before installing keeps the Ardnode dependency resolvable in the same
command. One tap holds all three casks for that reason: Homebrew resolves a cask
dependency only against an installed tap.

| Cask | Contents |
| --- | --- |
| `ardcode` | Ardcode app and the code exploration CLI |
| `ardterm` | Ardterm terminal app |
| `ardnode` | Ardnode mesh host helper and Screen Sharing proxy |

All casks support Apple silicon Macs running macOS 26 (Tahoe).

## Migrate from the per-product taps

Earlier instructions installed from `ardvis/ardcode-dist`, `ardvis/ardterm-dist`,
or `ardvis/ardnode-dist`. Their casks moved here, and every product's assets
followed.

```sh
brew tap                        # list the Ardvis taps you have installed
brew untap ardvis/ardcode-dist  # repeat for ardvis/ardterm-dist, ardvis/ardnode-dist
brew trust --tap ardvis/tap
brew tap ardvis/tap
brew upgrade --cask ardcode     # or ardterm; reinstalls from this tap
```

Untapping does not uninstall an app or delete its data, and `brew upgrade`
reinstalls an already-installed cask from the new tap at the published version.
Trust entries recorded for the old taps can stay: no cask is loaded from them
again.

## Release assets

Releases in this repository hold the signed, notarized app archives the casks
download, so one repository holds everything a Homebrew install reads. Tags carry
the product name because this repository hosts all three: `ardcode-v0.8.56`,
`ardterm-v0.1.21`, `ardnode-v0.1.1`. Ardterm and Ardnode releases contain the
archive, its `SHA256SUMS`, the resolved `Package.resolved`, and `release.json`;
Ardcode releases contain `ardcode-macos-arm64.tar.gz`, its `.sha256`, and an
SPDX SBOM. The `.github/workflows/release-attestation.yml` workflow here attests
Ardcode's archives on the release event, and Ardcode's release waits for and
verifies that attestation before it finishes.

Releases published before the move live in the per-product `-dist` repositories,
and the casks for those versions still download from there. `ardcode-dist` keeps
those archives and is no longer in any release path.

## Release metadata

Each product's release script writes its cask and its release assets here and
pushes the cask after the signed, notarized assets are published. Casks,
versions, and checksums are generated from the product release templates; do not
hand-edit them.
