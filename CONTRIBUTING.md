# Contributing

ShipKit's source is being extracted from the ShipIt repository; until that lands, **code changes are proposed and
reviewed there**, not here. This repository carries the consumer docs, the release assets and the issue reports about
installation and the published artifacts.

## Reporting instead of coding

- **A bug in a release** — open an issue here with the version, the command, the expected and actual output, and the
  smallest reproduction.
- **A security issue** — do **not** open a public issue; use GitHub's private vulnerability reporting on this
  repository (see [SECURITY.md](SECURITY.md)).
- **A docs problem** — a pull request against the Markdown here is welcome.

## Confidentiality comes first

**No product note, ADR, roadmap history, report or mockup from a source repository may reach a generated project or
this public set.** If an example is needed, write a generic one. A real customer name, a real vendor payload or an
internal URL is a leak even in a comment.

## The rules the source repository holds

The framework is contributed to with a spec-first, test-first process: a user-visible change gets a change proposal and
its first task writes the failing check; nothing publishes from a red gate; kernel packages import only
`@shipkit/contracts`, another kernel package's entry, a declared dependency, their own relative files and `node:*`; a
version bump is its own change; dependencies are pinned exactly.

## Licence

By contributing you agree your contribution is licensed under the repository's MIT licence — see [LICENSE](LICENSE).
