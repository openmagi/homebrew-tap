# OpenMagi Homebrew Tap

This tap publishes OpenMagi and Magi Agent command-line tools.

## Magi Agent

The `magi-agent` formula installs the Open Magi Agent runtime and CLI:

```bash
brew install openmagi/tap/magi-agent
magi --help
magi-agent --help
```

The formula is bottled for supported macOS runners so normal installs do not
require users to compile from source or install extra developer tooling beyond
Homebrew's standard dependencies.

The formula is built from the versioned `openmagi/magi-agent` source release.
