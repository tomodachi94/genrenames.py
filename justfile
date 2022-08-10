#!/usr/bin/env just --justfile

# just is "just a command runner."
# Docs: https://just.systems/man/en/chapter_1.html

#PYTHON_BINARY := "./.venv/bin/python"
#PIP_BINARY := "./.venv/bin/pip"
PYTHON_BINARY := "python"
PIP_BINARY := "python -m pip"

VERSION := "0.2.0"

init-virtualenv:
	-mkdir ./tmp
	python3 -m venv ./.venv/
	sudo gem install fpm

install-dev: init-virtualenv
	{{ PIP_BINARY }} install poetry
	{{ PYTHON_BINARY }} -m poetry install

test: init-virtualenv
	{{ PYTHON_BINARY }} test/test_renames.py

check: install-dev
	{{ PYTHON_BINARY }} -m flake8 src/

build-nuitka: install-dev
	-mkdir ./tmp/
	{{ PYTHON_BINARY }} -m nuitka src/cli.py --onefile --output-dir ./tmp

build-doc:
	pandoc MANUAL.md -s -t man > tmp/genrenames.1

build-zip:
	-mkdir ./tmp
	python -m zipapp src/ -o ./tmp/genrenames.zip
	echo '#!/usr/bin/env python3' | cat - ./tmp/genrenames.zip > ./tmp/genrenames.bin
	chmod a+x ./tmp/genrenames.bin

build-deb: build-doc build-zip
	fpm \
	  -s dir -t deb \
	  -p ./tmp/genrenames_{{ VERSION }}-release_any.deb \
	  --name genrenames-py \
	  --license mit \
	  --version {{ VERSION }} \
	  --architecture all \
	  --depends python3 \
	  --description "Creates a renames.txt file from a tilesheet dump for ftb-rs." \
	  --url "https://github.com/tomodachi94/genrenames.py" \
	  --maintainer "Tomodachi94 <68489118+Tomodachi94@users.noreply.github.com>" \
	  ./tmp/genrenames.bin=/usr/bin/genrenames ./tmp/genrenames.1=/usr/share/man/man1/genrenames.1

build-rpm: build-doc build-zip
	fpm \
	  -s dir -t rpm \
	  -p ./tmp/genrenames.{{ VERSION }}.any.rpm \
	  --name genrenames-py \
	  --license mit \
	  --version {{ VERSION }} \
	  --architecture all \
	  --depends python3 \
	  --description "Creates a renames.txt file from a tilesheet dump for ftb-rs." \
	  --url "https://github.com/tomodachi94/genrenames.py" \
	  --maintainer "Tomodachi94 <68489118+Tomodachi94@users.noreply.github.com>" \
	  ./tmp/genrenames.bin=/usr/bin/genrenames ./tmp/genrenames.1=/usr/share/man/man1/genrenames.1

bump-version OLD_VERSION NEW_VERSION:
	find . -not -path "./.git/*" -type f -exec sed -i 's/{{ OLD_VERSION }}/{{ NEW_VERSION }}/g' {} \;
