# Ardvis Homebrew tap

Homebrew casks for the Ardvis macOS apps: Ardcode, Ardterm, and the Ardnode mesh
host helper.

## Install

```sh
brew tap ardvis/tap
brew install --cask ardcode     # or ardterm, or ardnode
```

`brew install --cask ardvis/tap/ardcode` also works, because Homebrew taps a
repository automatically for an explicit cask reference. Tap first when a
dependency is involved: Ardterm and Ardcode declare `depends_on cask: "ardnode"`,
and Homebrew resolves a cask dependency only against an already installed tap.
With the casks in one tap, the Ardnode dependency resolves during the same
install.

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
brew tap                       # list the Ardvis taps you have installed
brew untap ardvis/ardcode-dist # repeat for ardvis/ardterm-dist, ardvis/ardnode-dist
brew tap ardvis/tap
brew upgrade --cask ardcode    # or ardterm; reinstalls from this tap
```

Untapping does not uninstall an app or delete its data, and `brew upgrade`
reinstalls an already-installed cask from the new tap at the published version.

## Release metadata

Each product's release script writes its cask here and pushes it after the
signed, notarized release assets are published. Casks, versions, and checksums
are generated from the product release templates; do not hand-edit them.
Release assets stay in the per-product `-dist` repositories.
