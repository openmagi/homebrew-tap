# OpenMagi Homebrew Tap

This tap publishes OpenMagi and Magi Agent command-line tools.

## Magi Agent

The `magi-agent` formula installs the Open Magi Agent runtime and CLI:

```bash
brew update
brew install openmagi/tap/magi-agent
```

Run the local API and dashboard:

```bash
magi-agent serve --port 8080
open http://localhost:8080/dashboard
```

Use the CLI:

```bash
magi --help
magi --output text "Summarize this repository"
magi-agent --help
```

The formula is bottled for supported macOS runners so normal installs do not
require users to compile from source or install extra developer tooling beyond
Homebrew's standard dependencies.

If Homebrew tries to build from source on macOS, update the tap metadata and
force the bottled install:

```bash
brew update
brew reinstall openmagi/tap/magi-agent --force-bottle
```

The formula is built from the versioned `openmagi/magi-agent` source release.
