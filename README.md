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

## Development

### Generating schema

You can generate schema using

`./.venv/bin/python -m eralchemy -i sqlite:///./tmp/dakanji.db -o images/schema.pdf`

### Inspecting the yomitan json schema

* [dictionary-term-bank-v3-schema.json](https://json-schema-viewer.vercel.app/view?url=https%3A%2F%2Fraw.githubusercontent.com%2Fyomidevs%2Fyomitan%2Frefs%2Fheads%2Fmaster%2Fext%2Fdata%2Fschemas%2Fdictionary-term-bank-v3-schema.json&description_is_markdown=on&expand_buttons=on&show_breadcrumbs=on&with_footer=on&template_name=js#items_items_i5_items_oneOf_i0)