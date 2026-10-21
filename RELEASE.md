# Releasing ShipKit

**Status:** while the source extraction from the ShipIt repository is pending, releases are built and tested in that
repository and published as assets here. When the extraction lands, this file and the release workflow move here with
the source. This repository is the consumer-facing distribution home from now on.

## The release artifact

One tarball, `shipkit-<version>-bundle.tar.gz`, containing:

| Path | Purpose |
|---|---|
| `kernel/*.tgz` | the eight `@shipkit/*` packages |
| `template/*.tgz` + `.manifest.json` | the standard template and the sha256 manifest `@shipkit/registry` verifies |
| `install.sh` | the installer (local toolchain + render + launcher; no registry) |
| `INSTALL.md`, `QUICKSTART.md`, `UPGRADE.md`, `RELEASE.md`, `README.md` | the consumer docs for this version |
| `VERSION`, `SHA256SUMS`, `LICENSE` | version, checksum of every asset, terms |

## Before publishing

1. One version truth: the template manifest, the template package and the kernel packages carry the same version line.
2. The gate is green in the source repository (CI is disabled there; paste the run into the release notes).
3. The template's confidentiality check passes on a real render, and no product note, ADR, roadmap history, report,
   mockup or credential is in the payload.
4. The bundle installs into an empty directory and the generated project's `./shipkit verify` passes.
5. `SHA256SUMS` covers every asset and verifies.

## Build and test the bundle (source repository)

```bash
pnpm kit:release                          # dist/shipkit
cd dist/shipkit
shasum -a 256 -c SHA256SUMS
target=$(mktemp -d)/probe
SHIPKIT_HOME=$(mktemp -d) bash install.sh "$target" --set projectSlug=release-probe
cd "$target" && pnpm install && ./shipkit verify
tar czf ../shipkit-<version>-bundle.tar.gz -C .. shipkit
```

## Publish here

```bash
gh release create shipkit-v<version> ../shipkit-<version>-bundle.tar.gz.sha256 ../shipkit-<version>-bundle.tar.gz \
  --repo minhlucvan/shipkit --title "ShipKit <version>" --notes-file /tmp/shipkit-notes.md
```

The tag is `shipkit-v<version>`. Do not move or delete a published tag; ship a new patch instead. Rollback means
deleting the release and tag and publishing the next version.

## Release notes should name

- the version and the fact that installation is a bundle, not an npm package;
- the supported Node/pnpm versions;
- what changed since the previous release;
- the honest limits from [README.md](README.md) ("what this does not prove").

## After publishing

- Update [INSTALL.md](INSTALL.md) and [QUICKSTART.md](QUICKSTART.md) if the download command or the bundle name changed.
- The npm path (kernel packages + template with provenance) is a separate, later decision; nothing in this repository
  publishes to npm today.
