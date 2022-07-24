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
