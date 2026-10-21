# ShipKit quickstart — a project and its first shipped change in about ten minutes

The shortest honest path from nothing to a project whose gate is green and whose first change is archived.

## 1. Install the kit and generate a project

```bash
mkdir -p ~/shipkit && cd ~/shipkit
gh release download shipkit-v0.2.0 -p 'shipkit-0.2.0-bundle.tar.gz'
tar xzf shipkit-0.2.0-bundle.tar.gz
bash shipkit-0.2.0/install.sh ~/projects/my-product --set projectName="My Product" --set projectSlug=my-product
cd ~/projects/my-product
pnpm install
```

## 2. Read what the kit wrote

- `AGENTS.md` — the rules an agent holds in this project.
- `docs/product/home.md` and `docs/product/roadmap/` — the product and its seeded roadmap.
- `openspec/README.md` and `openspec/changes/example-change/` — the change loop and its worked example.
- `shipkit.config.yml` — the paths, gate steps and driver the CLI reads.

## 3. Run the gate

```bash
./shipkit doctor     # config, record, kernel, paths
./shipkit verify     # lint, typecheck, check, test, specs, e2e generation — step by step
pnpm verify          # the same gate through the project's own scripts
```

## 4. Ship the first change

If you are in an interactive DeepSeek Harness session, set the session's goal first so every turn works the same
outcome:

```text
/goal ship my-first-change: the check, the implementation, the archive
```

Then let the project's ledger name the work:

```bash
./shipkit plan                      # the tracker's next eligible item
pnpm openspec new change my-first-change --schema feature
```

Then follow the loop the example change shows:

1. Write the check first and paste the failure into `openspec/changes/my-first-change/verification.md` (task 1.1).
2. Implement until it passes; paste the green run.
3. `pnpm openspec validate my-first-change --strict`
4. `pnpm openspec archive my-first-change -y`
5. `pnpm verify` once more; keep the tree clean.

`./shipkit next` names the next eligible roadmap item; `./shipkit check` runs the project's own checks even when the
project already has a `pnpm check` script.

## 5. Where the process lives

| File | What it is |
|---|---|
| `AGENTS.md` / `CONTEXT.md` | the rules and the vocabulary an agent works by |
| `openspec/` | the change loop: proposal, flows, spec delta, tasks, verification, archive |
| `docs/product/roadmap/` | the ledger: milestones and `rm-*` items the tracker reads |
| `docs/product/` | the product vault (features, stories, rules, decisions) |
| `.agents/skills/` | the skills a session loads for the work |

## What the kit does not promise

A green gate is a shape check, not a product review. The template proves a project generates and its gate passes; it
cannot promise the scaffold is complete for your answers or that the roadmap it seeds is your roadmap. See
[README.md](README.md) and [UPGRADE.md](UPGRADE.md).
