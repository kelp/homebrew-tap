# kelp/homebrew-tap

A [Homebrew](https://brew.sh) tap for Travis Cole's
([@kelp](https://github.com/kelp)) projects.

## Install

Install any formula with its fully-qualified name (no separate
`brew tap` needed):

```sh
brew install kelp/tap/<formula>
```

For example:

```sh
brew install kelp/tap/vibeutils
```

Or add the tap once and install by bare name:

```sh
brew tap kelp/tap
brew install vibeutils
```

Upgrade later with `brew update && brew upgrade <formula>`.

## Formulae

| Formula | Description |
| --- | --- |
| [`vibeutils`](https://github.com/kelp/vibeutils) | Modern Unix utilities with colors, icons, and progress bars |
| [`gale`](https://github.com/kelp/gale) | Fast, isolated package management for developers |
| [`bluemastodon`](https://github.com/kelp/bluemastodon) | Synchronize posts from Bluesky to Mastodon |
| [`webdown`](https://github.com/kelp/webdown) | Convert web pages to clean, readable Markdown |

Versions track each project's latest release; run `brew info
kelp/tap/<formula>` to see what is currently packaged.

### Notes

- **vibeutils** installs every command with a `v` prefix
  (`vls`, `vcp`, `vrm`, …) to avoid clobbering the system tools.
  To use the unprefixed names, put the `vibebin` directory on
  your `PATH` (see `brew info kelp/tap/vibeutils` for the exact
  line). On Apple Silicon, a prebuilt bottle is available; other
  platforms build from source (requires the `zig` build dep).
- **gale** manages packages under `~/.gale`. After install, add
  `~/.gale/current/bin` to your `PATH` and, for per-project
  environments, wire up the direnv hook — `brew info
  kelp/tap/gale` prints both commands.

## Tap Trust

Homebrew is rolling out
[Tap Trust](https://docs.brew.sh/Tap-Trust), which limits how
much non-official tap code Homebrew evaluates by default. **No
action is required from this tap or its maintainer** — trust is
controlled entirely on the installing user's side.

During the current transition, third-party taps still work; you
may see a `brew doctor` notice about untrusted taps. When
enforcement lands (Homebrew 5.2.0 / 6.0.0), installing with the
fully-qualified `kelp/tap/<formula>` form trusts just that item,
or you can trust the whole tap up front:

```sh
brew trust kelp/tap
```

To enforce explicit trust today, set
`HOMEBREW_REQUIRE_TAP_TRUST=1`.

## License

Each formula installs software under its own license (see the
linked project repositories). The formula definitions in this
tap are MIT licensed.
