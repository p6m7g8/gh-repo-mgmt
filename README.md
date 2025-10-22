# P6’s POSIX.2: gh-repo-mgmt

## Table of Contents

- [P6’s POSIX.2: gh-repo-mgmt](#p6s-posix2-gh-repo-mgmt)
  - [Table of Contents](#table-of-contents)
  - [Badges](#badges)
  - [Summary](#summary)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Commands](#commands)
    - [Options](#options)
    - [Aliases](#aliases)
    - [Functions](#functions)
  - [Examples](#examples)
  - [Hierarchy](#hierarchy)
  - [Contributing](#contributing)
  - [Code of Conduct](#code-of-conduct)
  - [Author](#author)

---

## Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Mergify](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges//gh-repo-mgmt/&style=flat)](https://mergify.io)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com//gh-repo-mgmt)

---

## Summary

---

## Installation

1. Ensure dependencies are installed:
   ```bash
   gh extension install p6m7g8/gh-repo-mgmt
   which jq gh
   ```
2. Verify access:
   ```bash
   gh auth status
   ```
3. Confirm the extension is working:
   ```bash
   gh repo-mgmt help
   ```

---

## Usage

```text
gh repo-mgmt [options] <cmd> [<args>...]
```

### Commands

| Command | Description |
|----------|-------------|
| `show <name>` | Show a branch ruleset |
| `update <name> <what>=<value>` | Update a branch ruleset |
| `update_topic` <name> <topics>... | Update topics |

### Options

| Option | Description |
|---------|-------------|
| `-h` | Show help message |

---

### Aliases

You can alias the script to shorten invocations:

```bash
alias ghut="gh update_topics
```

---

### Functions

| Function | Purpose |
|-----------|----------|
| `p6_usage()` | Prints help text |
| `p6_cmd_show(name)` | Shows JSON for a repo |
| `p6_cmd_update(name, ...)` | Updates |
| `p6_cmd_update_topics(name, ...)` | Updates topics |

---

## Examples

---

## Hierarchy

```text
.
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── FUNDING
├── init.zsh
├── LICENSE
├── README.md
├── SECURITY.md
└── SUPPORT
```

---

## Contributing

Pull requests are welcome.
Please lint with `shellcheck`, test with `bash -n`.

See [How to Contribute](https://github.com//.github/blob/main/CONTRIBUTING.md).

---

## Code of Conduct

See [Code of Conduct](https://github.com//.github/blob/main/CODE_OF_CONDUCT.md).

---

## Author

**Philip M. Gollucci** <pgollucci@p6m7g8.com>