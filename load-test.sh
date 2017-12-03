#!/bin/bash
dowork() {
  echo "Starting i=$1, j=$2"
  cat faas-perl-bibtex-2-html/function/example.bib | faas-cli invoke faas-perl-bibtex-2-html
  echo "Done i=$1, j=$2"
}

export -f dowork

COUNT=100
PARALLELISM=8

for ((i=1;i<=COUNT;i++)); do
      printf "%s\0" "$i"
done | xargs -0 -n 2 -P $PARALLELISM bash -c '1>/dev/null dowork "$@"' --
