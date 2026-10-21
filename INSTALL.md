# Installing ShipKit (without the npm registry)

> If `gh release download shipkit-v0.1.0` answers 404, the 0.1.0 release is still a draft: publish it from this
> repository's Releases page first (or ask the maintainer), then the command below works.

ShipKit is not published to npm yet. A release is a single bundle tarball, and installing is a local operation: no npm
account, no `npm publish` and no registry upload of ShipKit's packages.

> What "without npm" means here: ShipKit's own packages come from the bundle's local tarballs, never the npm registry.
> The installer uses the `npm` CLI that ships with Node for those tarballs (pnpm refuses a local set whose members
> declare each other by exact version); the generated project's third-party dependencies (`yaml`, the build tooling)
> are ordinary public packages.

## Prerequisites

- Node.js 24 (`node --version`), which brings the `npm` CLI
- pnpm 12 for the generated project (`corepack enable`, or `npm i -g pnpm@12`)
- the [GitHub CLI](https://cli.github.com/) (`gh`) if you download with the command below, otherwise use the release page

## 1. Download and extract the bundle

```bash
mkdir -p ~/shipkit && cd ~/shipkit
gh release download shipkit-v0.1.0 -p 'shipkit-0.1.0-bundle.tar.gz'
tar xzf shipkit-0.1.0-bundle.tar.gz
```

Or download `shipkit-0.1.0-bundle.tar.gz` from the Releases page into `~/shipkit` and extract it. The bundle contains:

| Path | What it is |
|---|---|
| `kernel/*.tgz` | the eight `@shipkit/*` packages |
| `template/*.tgz` + `.manifest.json` | the standard template and the sha256 manifest `@shipkit/registry` verifies |
| `install.sh` | the installer |
| `INSTALL.md`, `QUICKSTART.md`, `UPGRADE.md`, `RELEASE.md`, `README.md` | the consumer docs for this version |
| `VERSION`, `SHA256SUMS`, `LICENSE` | what it is, the checksum of every asset, and the terms |

Check the bundle before running it:

```bash
cd shipkit-0.1.0
shasum -a 256 -c SHA256SUMS   # or: sha256sum -c SHA256SUMS
```

## 2. Install into a new, empty directory

```bash
bash install.sh ~/projects/my-product --set projectName="My Product" --set projectSlug=my-product
```

The installer:

- installs the local kernel and template tarballs into a toolchain at `~/.local/share/shipkit`
  (`SHIPKIT_HOME` overrides the root),
- renders the standard template with `shipkit init`,
- writes a `./shipkit` launcher in the project.

Nothing is added to your global PATH.

## 3. Finish the generated project

```bash
cd ~/projects/my-product
pnpm install
./shipkit doctor     # config, record, kernel and paths
./shipkit check      # the project's own check list
./shipkit verify     # the project's own gate, step by step
pnpm verify          # the same gate through the project's package scripts
```

## Existing project

```bash
bash install.sh ~/projects/existing --existing
```

This installs the toolchain and the launcher but does not render the template. A new project started from the bundle
is the supported first path; adoption of an existing tree is a manual, reviewable step.

## Upgrade (manual until there is a registry)

Download the newer bundle, extract it and run its installer against the project with `--existing` to replace the
toolchain (it does not touch project files). Then dry-run and apply the template upgrade:

```bash
./shipkit upgrade --template "${SHIPKIT_HOME:-$HOME/.local/share/shipkit}/kit/node_modules/shipkit-tpl-mono-repo-std" --dry-run
./shipkit upgrade --template "${SHIPKIT_HOME:-$HOME/.local/share/shipkit}/kit/node_modules/shipkit-tpl-mono-repo-std"
./shipkit verify
```

Read [UPGRADE.md](UPGRADE.md) first: an upgrade regenerates the files the template classifies `shared` and leaves
everything else alone.

## Uninstall

```bash
rm -rf "${SHIPKIT_HOME:-$HOME/.local/share/shipkit}"
rm -f ~/projects/my-product/shipkit
```

## Building from source

The source is not in this repository yet (the extraction is tracked separately). Until it lands, the bundle is built
from the ShipIt repository:

```bash
git clone https://github.com/minhlucvan/shipit.git
cd shipit
pnpm install
bash shipkit/release.sh --out dist/shipkit
cd dist/shipkit
tar czf ../shipkit-0.1.0-bundle.tar.gz -C .. shipkit
```

## Troubleshooting

- **`pnpm add` of the tarballs fails with 404 for `@shipkit/*`** — expected: the local set declares its members by
  exact version and pnpm resolves them too early. The installer uses npm for this one step.
- **`pnpm install` needs the registry** — the generated project's third-party dependencies are normal public packages;
  ShipKit itself is already installed.
- **`./shipkit` cannot find the toolchain** — the launcher reads `SHIPKIT_HOME` at run time; set it in your shell if you
  moved the toolchain out of `~/.local/share/shipkit`.
- **`./shipkit doctor` prints `contracts unknown`** — known cosmetic issue in 0.1.0: the generated record omits the
  contracts range; `doctor` still resolves the kernel and paths.

## What this does not prove

Installing proves the artifacts are well-formed and the project renders. It does not prove the kit is right for your
project, that a green gate means working software, or that a live agent integration works — see
[README.md](README.md).
