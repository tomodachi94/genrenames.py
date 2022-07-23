#!/usr/bin/env just --justfile

# just is "just a command runner."
# Docs: https://just.systems/man/en/chapter_1.html

PYTHON_BINARY := "./.venv/bin/python"
PIP_BINARY := "./.venv/bin/pip"

init-virtualenv:
	python3 -m venv ./.venv/

install-dev: init-virtualenv
    {{ PIP_BINARY }} install -r requirements-dev.txt

test: init-virtualenv
	{{ PYTHON_BINARY }} test/test_renames.py

check: install-dev
	python3 -m flake8 src/
