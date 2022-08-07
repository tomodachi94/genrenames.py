# Installation

This document guides you through installation.

## Debian-based machines

Run the following commands to add the package archive and install the software:

```sh
curl -s --compressed "https://tomodachi94.github.io/genrenames.py/ppa/KEY.gpg" | sudo apt-key add -
sudo curl -s --compressed -o /etc/apt/sources.list.d/genrenames.list "https://tomodachi94.github.io/genrenames.py/ppa/deb/main.list"
sudo apt update
sudo apt install genrenames-py
```

Alternatively, download `genrenames.deb` and install it with `sudo gdebi -i ~/Downloads/genrenames.deb`.

## Fedora-based machines

Download `genrenames.rpm` and install it with `sudo rpm -i ~/Downloads/genrenames.rpm`.

## Something else/I don't want a package

Download the .zip file from the latest release and execute it with `python3 genrenames.zip`. (Yes, [Python can execute applications from ZIP files.](https://docs.python.org/3/library/zipapp.html)).
