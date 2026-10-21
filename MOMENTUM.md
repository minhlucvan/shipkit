# Momentum — the productivity-first method

Momentum is ShipKit's delivery method for turning a mockup into production software without lowering the bar. It is a
method pack layered over `product`: the lifecycle, the gate and the identities stay; the delivery physics change.

**Quality is fixed.** Staged delivery, preview exposure and recorded deferral never move the production-readiness
contract. Deferred scope is a ledger entry, not a weaker checklist.

## The four moves

1. **Rank by value density.** Groom each item to RICE (`reach × impact × confidence / effort`), effort including QA,
   hardening and the tooling the item consumes. Risk tier sits beside the score. H0/H1 items stay out of `plan` until
   groomed.
2. **Plan only as far as the work is near.** H0 vision, H1 milestone, H2 groomed item, H3 batch brief. A far note may
   be blurry; a groomed item may not.
3. **Ship in batches and lanes.** Similar units — screens, components, endpoints — are one `batch` change: one
   `units.md`, one brief, one gate, one verification. Parallel lanes write disjoint paths behind contract-first
   interfaces and take one integration gate.
4. **Build leverage first.** A generator or QA harness that makes N units cheap and verifiable ships before the N
   units, with its own acceptance and a payback statement.

## Patterns

- **Batch horizontal delivery** — all screens static on seed data, preview-only, then wire, then harden.
- **Leverage-first** — mockup→component generator, screenshot diff, a11y report, batch gate.
- **Contract-first lanes** — shared shapes land before either lane consumes them.
- **Two-speed gates** — a light tier before a preview for reversible UI; `high`/`medium` risk always takes `full`.
- **Recorded deferral** — cost, trigger, owner, expiry; no silent debt.
- **Context packs** — one batch brief with units, file map, mockup slice, token budget and lane scopes.

## Install

Momentum ships in the release bundle under `methods/momentum`:

```bash
./bin/shipkit method add momentum@1.0.0 \
  --pack "${SHIPKIT_HOME:-$HOME/.local/share/shipkit}/kit/methods/momentum" \
  --base "${SHIPKIT_HOME:-$HOME/.local/share/shipkit}/kit/methods/product"
```

Then set `method: { id: momentum, version: 1.0.0 }` in `shipkit.config.yml`. See [INSTALL.md](INSTALL.md).

## The evaluation

Momentum is adopted only if a controlled trial proves it: three mockups (static page, dashboard, CRUD), the current
method versus Momentum, the same starting project and model/time budget, quality held fixed. It must show a better or
equal production checklist and no more defect escapes, with materially better cycle time and tokens per unit. The
numbers are published for both arms, including where Momentum loses.

## Hard-won rules (ToolShed trial)

The first real roadmap built with Momentum scored 6/10 until four rules were enforced. They are now part of the method
and the generated project's gate:

1. **An enabler is a dependency.** A seed set, screen kit or QA harness is leverage only when the items it serves list
   it in `depends_on`; RICE alone will schedule the consumers first. The Method ships an `enabler: yes` field and the
   planning skills say to wire the dependency.
2. **Every milestone plans its distribution.** A shelf with no users is a catalogue. The launch/invite item belongs in
   the first milestone beside the supply that makes joining worthwhile; the ToolShed launch scored 4000 RICE and moved
   to the front once it existed.
3. **Confidence over 60 cites evidence.** The generated `pnpm check` now fails an item whose `confidence` is above 60
   with no `evidence:` line (a path, a number, a person). A confident guess is worse than a humble one; the ToolShed
   test lowered six items from 90/80/70 to 50 rather than invent evidence.
4. **Batch by context, not by slice.** Three batches (supply+launch, screen kit+preview, lend flow) beat nine
   single-screen changes. `qa:batch` reads the units table and its `Context budget:` line, and the project's `verify`
   runs it.

### What the gate now enforces in a generated project

- `production-contract` — the project has a written gate, checklist and preview rule.
- `deferred-scope` — every debt entry names cost, trigger, owner and expiry.
- `momentum-evidence` — high confidence cites evidence.
- `qa:a11y` and `qa:batch` run inside `pnpm verify`; `verify:light` is the preview tier.

The roadmap itself still lives or dies by its evidence: Momentum makes the questions unavoidable, not the answers true.
