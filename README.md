# genrenames.py

This is a script/library to generate a `renames.txt` file for [ftb-rs's tilesheet uploading function](https://github.com/FTB-Gamepedia/ftb-rs/), but in Python.

For help, execute `python3 src/cli.py -h`.

## Installation

### Debian- and Ubuntu-based Linux distributions

This project has a package archive. Install it like so:

```sh
curl -s --compressed "https://tomodachi94.github.io/genrenames.py/ppa/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/genrenames.list "https://tomodachi94.github.io/genrenames.py/ppa/deb/main.list"
sudo apt update
sudo apt install genrenames-py
```

Alternatively, you can download a `.deb` package from [here](https://tomodachi94.github.io/genrenames.py/ppa/deb/genrenames-0.1.0-any.deb).

### Other operating systems

Ensure you have Python 3 installed and on your $PATH.

Download the `src/` folder, then execute `python3 src/cli.py --help` to get usage info.

## Prior ~~art~~ scripts

- SizableShrimp's `genrenames.bat`, for Windows machines. A copy is in the `external/genrenames.bat` file for posterity.
- SizableShrimp's `genrenames.bash`, for Linux and other OSes which support Bash. A copy is in the `external/genrenames.bash` file for posterity.
