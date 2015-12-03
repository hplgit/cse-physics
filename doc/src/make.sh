#!/bin/bash
name=uniped15

set -x

function system {
  "$@"
  if [ $? -ne 0 ]; then
    echo "make.sh: unsuccessful command $@"
    echo "abort!"
    exit 1
  fi
}

opt="--encoding=utf8"
#opt=

# Compile to latex and pdf
system doconce format pdflatex $name --latex_code_style=vrb $opt --latex_table_format=footnotesize --section_numbering=off
system pdflatex $name
system bibtex $name
system pdflatex $name
system pdflatex $name

# Compile to HTML
system doconce format html $name $opt --html_style=bootswatch_journal --html_share=http://hplgit.github.io/cse-physics/doc/pub/uniped15.html

# Publish
cp $name.pdf $name.html ../pub
cp -r fig ../pub
