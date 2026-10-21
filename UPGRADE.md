# Upgrading ShipKit

A project records what it was generated from in `.shipkit/template.json` (or the `template` key of
`shipkit.config.yml`). This page is the promise about what a release may change, and how a project finds out.

## The version policy

The kernel packages and the one standard template version as **one fixed group** while the format settles
([[adr-052-shipkit-is-a-project-independent-framework]]): a release bumps them together and is announced as one
compatibility line. Independent versioning starts only when an external consumer pins one package.

| Release | May change | Must announce |
|---|---|---|
| **patch** | a fix that changes no shape | nothing |
| **minor** | a new optional key, a new check, a new job, a new template file that is not `shared` | the added key or file, in the changelog |
| **major** | the config shape, the template manifest, a `shared` template file's contract, a removed job | the migration, in the changelog and here |

Breaking either the config shape or the template manifest is a **major**: a project's `shipkit.config.yml` and
its template record are what an upgrade reads.

The release commit bumps `package.json` and `template.json` together: the template package mirrors the manifest's
`version`, and `pnpm shipkit:catalogue --check` fails when they disagree. `pnpm changeset version` writes the package
bump; the manifest's one line is part of the same release commit.

## How a project learns it is behind

```bash
pnpm shipkit doctor
```

Doctor prints the record the project carries beside the kernel it installed:

```
version: shipkit-tpl-mono-repo-std@0.1.0, contracts ^0.1.0
kernel:  @shipkit/contracts 0.1.0
change:  current
```

When the recorded range no longer admits the installed kernel it prints `change: behind` and names both versions.
Doctor reads only the project — it does not fetch a registry — so "behind" means *behind the code you installed*,
and the next step is a dependency bump.

## Upgrading a project

ShipKit is not on npm yet, so the toolchain comes from a GitHub Release bundle (see [INSTALL.md](INSTALL.md)). Re-run
the new bundle's installer against the project with `--existing` to replace the toolchain, then:

```bash
./shipkit upgrade --template "${SHIPKIT_HOME:-$HOME/.local/share/shipkit}/kit/node_modules/shipkit-tpl-mono-repo-std" --dry-run   # what would be written
./shipkit upgrade --template "${SHIPKIT_HOME:-$HOME/.local/share/shipkit}/kit/node_modules/shipkit-tpl-mono-repo-std"
./shipkit verify
```

(When the npm release exists the same steps are `pnpm add -D @shipkit/cli@latest` and a template directory the package
manager installed.)

- `upgrade` regenerates only the files the template classifies `shared`. Everything else — your config, your
  services, your notes — is left alone.
- A file the classification does not name is **excluded**, never shared: silence in the classification means your
  file stays yours.
- The dry run prints every path it would write and writes nothing.
- After a major, read the changelog entry and this page's version table before running `upgrade`; the migration is
  in the entry, not in the tool.
