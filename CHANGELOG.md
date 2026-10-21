# Changelog

## 0.1.0 — 2026-10-21

First bundle release of the kit, published as `shipkit-0.1.0-bundle.tar.gz`.

**Kernel packages:** `@shipkit/contracts`, `kernel-core`, `kernel-checks`, `kernel-tracker`, `kernel-widgets`,
`registry`, `cli`, `drivers` (all 0.1.0).

**CLI jobs:** `init`, `attach`, `doctor`, `upgrade`, `plan`, `next`, `verify`, `check`, `run`, `method`, `preset`.

**Template:** `shipkit-tpl-mono-repo-std` 0.1.0 — a pnpm + turbo monorepo with the gate, the OpenSpec loop, the seeded
roadmap, the agent roles and skills, the e2e scaffold and no product code.

**Installation:** a local installer over the bundle's tarballs (`install.sh`), a toolchain under `SHIPKIT_HOME`, a
rendered project and a `./shipkit` launcher. No npm publication and no registry fetch of ShipKit's packages.

**Known at 0.1.0:** `shipkit doctor` prints `contracts unknown` for a generated project (the rendered record omits the
contracts range); the agent-driver path is proven with recorded fixtures, not a live model turn; the source extraction
from the ShipIt repository is pending.
