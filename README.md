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
or `ardvis/ardnode-dist`. Those repositories now host release assets only; their
casks moved here.

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

## Release metadata

Each product's release script writes its cask here and pushes it after the
signed, notarized release assets are published. Casks, versions, and checksums
are generated from the product release templates; do not hand-edit them.
Release assets stay in the per-product `-dist` repositories.
