import re


with open("CHANGELOG.md", mode="r", encoding="utf8") as f:
    changelog = f.read()

newest_changes = re.search("(##.*?)----------------", changelog, re.DOTALL).groups()[0]
print(newest_changes)