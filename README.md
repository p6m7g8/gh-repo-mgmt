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

---

## Summary

`gh-repo-mgmt` is a GitHub CLI extension that provides repository management commands not available in the native `gh` CLI:

- **transfer**: Transfer repository ownership between users/organizations (idempotent)
- **ensure**: Declaratively create or update repositories with settings (idempotent)

For all other repository operations, use the native `gh repo` commands.

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

| Command                            | Description                                      |
|----------------------------------- | ------------------------------------------------ |
| `transfer <name> <new-owner>`      | Transfer repository ownership (idempotent)       |
| `ensure <name> [options]`          | Ensure repository exists with settings (idempotent) |

### Native `gh repo` Commands

For other operations, use the native GitHub CLI:

| Command                          | Description                 |
|--------------------------------- | --------------------------- |
| `gh repo create`                 | Create a repository         |
| `gh repo delete`                 | Delete a repository         |
| `gh repo rename`                 | Rename a repository         |
| `gh repo archive`                | Archive a repository        |
| `gh repo unarchive`              | Unarchive a repository      |
| `gh repo edit`                   | Update repository settings  |
| `gh repo edit --add-topic`       | Add topics                  |
| `gh repo edit --remove-topic`    | Remove topics               |
| `gh repo list`                   | List repositories           |
| `gh repo view`                   | Show repository details     |

### Options

| Option  | Description       |
| --------|------------------ |
| `-h`    | Show help message |

---

### Ensure Options

| Option                    | Description                           |
| ------------------------- | ------------------------------------- |
| `--public`                | Create as public repository (default) |
| `--private`               | Create as private repository          |
| `--description=<text>`    | Repository description                |
| `--homepage=<url>`        | Repository homepage URL               |
| `--disable-wiki`          | Disable wiki                          |
| `--disable-issues`        | Disable issues                        |
| `--disable-projects`      | Disable projects                      |
| `--topics=<tag1,tag2>`    | Comma-separated repository topics     |

---

### Functions

| Function                          | Purpose                                          |
| ----------------------------------|------------------------------------------------- |
| `p6_usage()`                      | Prints help text                                 |
| `p6_cmd_transfer(name, owner)`    | Transfers repository to new owner (idempotent)   |
| `p6_cmd_ensure(name, ...)`        | Creates or updates repository (idempotent)       |

---

## Examples

```bash
# Transfer repository ownership
gh repo-mgmt transfer p6m7g8/my-repo new-owner

# Ensure repository exists with specific settings
gh repo-mgmt ensure p6m7g8/my-repo --private --description="My project" --topics="cli,tool"

# Create public repo with topics (if doesn't exist)
gh repo-mgmt ensure p6m7g8/new-repo --public --topics="opensource,bash"

# Update existing repo settings
gh repo-mgmt ensure p6m7g8/existing-repo --private --disable-wiki
```

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
