#!/usr/bin/env just --justfile

# just is "just a command runner."
# Docs: https://just.systems/man/en/chapter_1.html

#PYTHON_BINARY := "./.venv/bin/python"
#PIP_BINARY := "./.venv/bin/pip"
PYTHON_BINARY := "python"
PIP_BINARY := "python -m pip"

init-virtualenv:
	#!/bin/bash
	mkdir ./tmp
	python3 -m venv ./.venv/

install-dev: init-virtualenv
	{{ PIP_BINARY }} install poetry
	{{ PYTHON_BINARY }} -m poetry install

test: init-virtualenv
	{{ PYTHON_BINARY }} test/test_renames.py

check: install-dev
	{{ PYTHON_BINARY }} -m flake8 src/

build: install-dev
	mkdir ./tmp/
	{{ PYTHON_BINARY }} -m nuitka src/cli.py --onefile --output-dir ./tmp

build-doc:
	pandoc MANUAL.md -s -t man > tmp/genrenames.1

build-deb: build build-doc
	fpm \
	  -s dir -t deb \
	  -p ./tmp/genrenames-0.1.1-1-x86_64.deb \
	  --name genrenames-py \
	  --license mit \
	  --version 0.1.1 \
	  --architecture x86_64 \
	  --description "Creates a `renames.txt` file from a tilesheet dump for `ftb-rs`." \
	  --url "https://github.com/tomodachi94/genrenames.py" \
	  --maintainer "Tomodachi94 <68489118+Tomodachi94@users.noreply.github.com>" \
	  ./tmp/cli.bin=/usr/bin/genrenames tmp/genrenames.1=/usr/share/man/man1/genrenames.1

bump-version OLD_VERSION NEW_VERSION:
	find . -type f -exec sed -i 's/{{ OLD_VERSION }}/{{ NEW_VERSION }}/g' {} \;
