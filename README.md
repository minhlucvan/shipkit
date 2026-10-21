# ShipKit

ShipKit is a project-independent process kernel: one contracts package, kernel packages, a CLI and one standard
template, so a project gets the gate, the ledger, the roadmap and the wave loop without forking anyone's repository.
It never wears a product's name — a project's paths, packages and boards come from that project's `shipkit.config.yml`.

| Piece | What it is |
|---|---|
| `@shipkit/contracts` | the config, the template manifest and the ports everything couples through |
| `@shipkit/kernel-core` | the tree reader, the check contract, the report printers |
| `@shipkit/kernel-checks` | the framework checks and their runner |
| `@shipkit/kernel-tracker` | the roadmap engine, the wave and run helpers |
| `@shipkit/kernel-widgets` | the widget vocabulary the agent generators read |
| `@shipkit/registry` | the template registry: a manifest over a packed tarball, a fetch that verifies it |
| `@shipkit/cli` | `init`, `attach`, `doctor`, `upgrade`, `plan`, `next`, `verify`, `check`, `run`, `method`, `preset` |
| `shipkit-tpl-mono-repo-std` | the standard template: a pnpm monorepo with the process and no product code |

> **Status — 0.1.0.** This repository is the kit's distribution home. The source extraction from the ShipIt repository
> is still pending; until it lands, the release bundle published here is built and tested there, and the same extraction
> moves the source, the checks and the release workflow into this repository. The artifacts and the docs here are the
> consumer contract; the "what this does not prove" section below is the honest part.

## Install it (no npm publication yet)

ShipKit is not on npm. A release is one tarball — the eight kernel packages, the standard template with its sha256
manifest, the installer, these docs, a version file, the licence and `SHA256SUMS`:

```bash
gh release download shipkit-v0.1.0 -p 'shipkit-0.1.0-bundle.tar.gz'
tar xzf shipkit-0.1.0-bundle.tar.gz
bash shipkit-0.1.0/install.sh ~/projects/my-product --set projectName="My Product" --set projectSlug=my-product
cd ~/projects/my-product
pnpm install
./shipkit doctor
./shipkit verify
```

The installer verifies nothing over the network for ShipKit itself: it installs the local tarballs into a toolchain at
`~/.local/share/shipkit` (`SHIPKIT_HOME` overrides it), renders the standard template and leaves a `./shipkit` launcher.
No npm account and no `npm publish` are involved; the generated project's third-party dependencies are ordinary public
packages. Full instructions and troubleshooting: [INSTALL.md](INSTALL.md); the ten-minute path:
[QUICKSTART.md](QUICKSTART.md).

## What this does not prove

Read this before adopting it, because a green gate proves less than it looks like it does:

- **A check proves the shape, not the product.** Every check prints what it does not prove; a green run says the files
  are where the rules expect them, not that the software is right.
- **The template proves a project generates and its own gate passes** — not that the generated project is a good
  project, that the scaffolding is complete for your answers, or that the roadmap it seeds is your roadmap.
- **The upgrade does not merge your edits.** It regenerates the files the template classifies `shared` and leaves
  everything else alone; a file the classification does not name is excluded, never shared.
- **The loop is deterministic but not omniscient.** Selection, retries, gates and completion are code; whether the work
  a session did is good is a review, not a check.
- **Nothing here calls a vendor by default.** A live agent integration is a manual run with a credential you supply.

## Docs

| File | What it is |
|---|---|
| [INSTALL.md](INSTALL.md) | installing from a release bundle, existing projects, upgrade, uninstall, troubleshooting |
| [QUICKSTART.md](QUICKSTART.md) | a project and its first shipped change in about ten minutes |
| [UPGRADE.md](UPGRADE.md) | the version policy and how a project learns it is behind |
| [RELEASE.md](RELEASE.md) | how a release is built, verified and published here |
| [CHANGELOG.md](CHANGELOG.md) | what each release carries |
| [CONTRIBUTING.md](CONTRIBUTING.md) | contribution rules and where the source lives today |
| [SECURITY.md](SECURITY.md) | reporting a vulnerability |

## Confidentiality

**No product note, ADR, roadmap history, report or mockup from a source repository may reach a generated project or
this public set.** The template's own check renders the standard into a clean directory and scans it for a forbidden
path before it is reported green; a contribution must pass it. If a change needs an example, write a generic one.

## Licence

MIT — see [LICENSE](LICENSE).
