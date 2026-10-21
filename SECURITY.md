# Security

## Reporting a vulnerability

Report privately, not in a public issue. Use GitHub's private vulnerability reporting on this repository
(`Security` → `Report a vulnerability`); if that is unavailable, open a minimal issue asking for a private channel and
disclose nothing in it.

Include: what you ran, what happened, what you expected, and the smallest reproduction. Do not include a real
credential, a customer payload or an unscrubbed vendor fixture — a report is not exempt from the confidentiality rule.

## What we promise

- An acknowledgement within seven days and a status within thirty.
- A fix released from the same gate as every other change: nothing publishes from a red gate.
- Credit in the changelog unless you ask otherwise.

## What ShipKit collects

Nothing. The framework is a set of packages and a CLI; no telemetry is sent, no account exists, and nothing registers
itself anywhere. Whatever a project you build with it collects is that project's business, not this framework's.

## What a project should watch

- **The version record.** `shipkit doctor` reports the template and contracts a project was generated from; a stale
  record is the first sign of drift.
- **The template classification.** A file the classification does not name is excluded and never shared, so a project's
  own files are safe from an upgrade — verify that before running one.
- **The bundle.** Verify `SHA256SUMS` before installing; the template's manifest is verified again when fetched.
