#!/usr/bin/env sh

pandoc --from=markdown --to=rst --output=Introduction.rst Introduction.md
pandoc --from=markdown --to=rst --output=Installation.rst Installation.md
pandoc --from=markdown --to=rst --output=Input.rst Input.md
pandoc --from=markdown --to=rst --output=Usage_manual.rst Usage_manual.md
pandoc --from=markdown --to=rst --output=FAQ.rst FAQ.md
pandoc --from=markdown --to=rst --output=Appendix.rst Appendix.md
pandoc --from=markdown --to=rst --output=Release_log.rst Release_log.md
#pandoc --from=markdown --to=rst --output=source/index.rst source/index.md

make html

