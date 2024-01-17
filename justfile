build: local-pub compile-snippets
    typst compile README.typ README.pdf 
    pandoc -t html -o README.md README.typ

local-pub:
    sh local-pub.bash

compile-snippets:
    sh compile-snippets.bash


