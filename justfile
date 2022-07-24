#!/usr/bin/env just --justfile

# just is "just a command runner."
# Docs: https://just.systems/man/en/chapter_1.html

PYTHON_BINARY := "./.venv/bin/python"
PIP_BINARY := "./.venv/bin/pip"
# PYTHON_BINARY := "python"
# PIP_BINARY := "python -m pip"

init-virtualenv:
	python3 -m venv ./.venv/

install-dev: init-virtualenv
	{{ PIP_BINARY }} install poetry
	{{ PYTHON_BINARY }} -m poetry install

test: init-virtualenv
	{{ PYTHON_BINARY }} test/test_renames.py

check: install-dev
	{{ PYTHON_BINARY }} -m flake8 src/

build: install-dev
	{{ PYTHON_BINARY }} -m nuitka src/cli.py --onefile

build-doc:
	pandoc doc/genrenames.md -s -t man > doc/genrenames.1

build-deb: build build-doc
	fpm \
	  -s dir -t deb \
	  -p genrenames-0.1.0-1-x86_64.deb \
	  --name genrenames-py \
	  --license mit \
	  --version 0.1.0 \
	  --architecture x86_64 \
	  --description "Creates a `renames.txt` file from a tilesheet dump for `ftb-rs`." \
	  --url "https://github.com/tomodachi94/genrenames.py" \
	  --maintainer "Tomodachi94 <68489118+Tomodachi94@users.noreply.github.com>" \
	  cli.bin=/usr/bin/genrenames doc/genrenames.1=/usr/share/man/man1/genrenames.1
