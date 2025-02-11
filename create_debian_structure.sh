#!/bin/bash
mkdir -p debian
cat <<EOL > debian/control
Source: cyckle-ai
Section: misc
Priority: optional
Maintainer: Your Name <youremail@example.com>
Build-Depends: debhelper (>= 9), python3
Standards-Version: 4.1.0
Homepage: https://github.com/vaultdweller-2287/Cyckle-ai
Package: cyckle-ai
Architecture: any
Depends: \${shlibs:Depends}, \${misc:Depends}, python3
Description: A graphical GPT4 wrapper built with the gpt4all python library that utilizes Cython and is locally run.
 Long description of your package.
EOL

cat <<EOL > debian/rules
#!/usr/bin/make -f
%:
	dh \$@
EOL

chmod +x debian/rules
