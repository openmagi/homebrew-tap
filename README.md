# OpenMagi Homebrew Tap

This tap is reserved for OpenMagi and Magi Agent command-line tools.

## Magi Agent

The `magi-agent` formula is not live yet. Do not document
`brew install openmagi/tap/magi-agent` as working until all of these are true:

1. A public Magi Agent CLI release artifact exists.
2. The artifact SHA-256 checksum is recorded.
3. `Formula/magi-agent.rb` points to that release artifact.
4. Homebrew audit and install smoke have passed from this tap.

Current blocker: `openmagi/magi-agent` has no approved public release artifact
for the Magi Agent CLI package yet.
