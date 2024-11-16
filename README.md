# DaKanji-DB

A set of tools to create the database used in DaKanji.
These tools are used for DaKanji v4 and onwards.

## Setup

### Python

For generating schema of the database python >= 3.8 is used.
Run the following commands to setup an environment

``` bash
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt
```

To generate schemas graphviz is required.
Install it like this

Macos: `brew install graphviz`
Linux:
Windows:

## Generating schema

You can generate schema using

`./.venv/bin/python -m eralchemy -i sqlite:///./tmp/dakanji.db -o images/schema.pdf`
