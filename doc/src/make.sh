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
system doconce format pdflatex $name $opt --latex_table_format=footnotesize --section_numbering=off --latex_font=palatino --latex_admon=yellowicon '--latex_admon_color=yellow!5' --latex_fancy_header --latex_code_style=pyg --latex_section_headings=blue --latex_colored_table_rows=blue
system pdflatex -shell-escape $name
system bibtex $name
system pdflatex -shell-escape $name
system pdflatex -shell-escape $name

system doconce format html $name $opt --html_style=bootswatch_journal "--html_body_style=font-size:20px;line-height:1.5" --html_share=http://hplgit.github.io/cse-physics/doc/pub/uniped15.html

# Publish
cp $name.pdf $name.html ../pub
cp -r fig ../pub
