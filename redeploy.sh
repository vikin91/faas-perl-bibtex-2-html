#!/bin/bash

FUNC_NAME="faas-perl-bibtex-2-html"

faas-cli remove "$FUNC_NAME"
faas-cli build "$FUNC_NAME" -f "$FUNC_NAME".yml
faas-cli deploy "$FUNC_NAME" -f "$FUNC_NAME".yml
