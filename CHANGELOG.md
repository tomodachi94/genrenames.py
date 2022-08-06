This project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html) and uses the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format.

## [unreleased]

- A filter has been added to only allow JPEGs and PNGs into `renames.txt` files. (30012c50bbb3f9f4b0a7df9acadf1e30c69edc58)
- Packages are now native Python files instead of a bulky native binary. (01365ef14f53fb42f8fa0cf111421eb2a5c73f5b)
- Executing `cli.py` with no arguments would throw an error, instead now it shows help. (f669ccfafe6af477a2cda4315986f3604e04a1b4)
- Return proper exit codes. (9619c335c43737c606e0e600a79519a4a61782f8)

## 0.1.1

- Add program description and consistently use `genrenames-py`.
- Add an argument, `--all-files`, which will dump all files at a directory in renames.txt format.
- Fix a bug where the final line of a `renames.txt` would be lacking an equals sign.

## 0.1.1

- Initial release. See [MANUAL.md](./MANUAL.md) for more information.
