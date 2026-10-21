# Changelog

## 0.2.0 — 2026-10-22

**Momentum** — the productivity-first method pack: `batch` changes with units and one gate, RICE/risk/horizon items,
evidence and enabler fields, north-star milestones, leverage/batch/lane skills. The generated gate now enforces the
production contract, deferred-scope fields and the evidence rule, and runs the QA harness (`qa:a11y`, `qa:batch`);
`verify:light` is the preview tier. The tracker honours RICE and `depends_on` note links. The release bundle carries the
method packs and the installer writes `bin/shipkit` (a root `shipkit` file blocked `shipkit/methods/`).

**0.1.0** — first bundle release.

## 0.2.0 — 2026-10-21

First bundle release of the kit, published as `shipkit-0.2.0-bundle.tar.gz`.

**Kernel packages:** `@shipkit/contracts`, `kernel-core`, `kernel-checks`, `kernel-tracker`, `kernel-widgets`,
`registry`, `cli`, `drivers` (all 0.2.0).

**CLI jobs:** `init`, `attach`, `doctor`, `upgrade`, `plan`, `next`, `verify`, `check`, `run`, `method`, `preset`.

**Template:** `shipkit-tpl-mono-repo-std` 0.2.0 — a pnpm + turbo monorepo with the gate, the OpenSpec loop, the seeded
roadmap, the agent roles and skills, the e2e scaffold and no product code.

**Installation:** a local installer over the bundle's tarballs (`install.sh`), a toolchain under `SHIPKIT_HOME`, a
rendered project and a `./shipkit` launcher. No npm publication and no registry fetch of ShipKit's packages.

**Known at 0.2.0:** `shipkit doctor` prints `contracts unknown` for a generated project (the rendered record omits the
contracts range); the agent-driver path is proven with recorded fixtures, not a live model turn; the source extraction
from the ShipIt repository is pending.
