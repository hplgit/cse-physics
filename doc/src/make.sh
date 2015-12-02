#!/bin/bash
name=unipub_paper15

set -x

function system {
  "$@"
  if [ $? -ne 0 ]; then
    echo "make.sh: unsuccessful command $@"
    echo "abort!"
    exit 1
  fi
}

#opt="--encoding=utf8"
opt=

# Compile to latex and pdf
system doconce format pdflatex $name --latex_code_style=vrb $opt
system pdflatex $name
system bibtex $name
system pdflatex $name
system pdflatex $name
