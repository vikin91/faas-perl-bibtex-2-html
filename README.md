# Perl BibTeX to HTML Converter with OpenFaaS

This code allows converting BibTeX to HTML based on modified BibStyle library. Prepared for serverless using OpenFaaS.

The goal of this project is to encapsulate low quality code (especially the BibStyleConverter) and remove it from the [BibSpace](https://github.com/vikin91/BibSpace) project.

## Usage with OpenFaaS and Docker Swarm deployed on local machine

```bash
$ docker swarm init
$ git clone https://github.com/openfaas/faas && \
  cd faas && \
  git checkout master && \
  ./deploy_stack.sh && \
  docker service ls

$ ./redeploy.sh

# Invoke the function
cat faas-perl-bibtex-2-html/function/example.bib | faas-cli invoke faas-perl-bibtex-2-html

# Runing load-test
./load-test.sh
```
