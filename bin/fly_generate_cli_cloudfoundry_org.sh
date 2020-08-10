#!/bin/bash

set -eu

CONCOURSE_SCRIPTS_DIR=/home/aberezovsky/workspace/concourse-scripts-docs
CLI_DOCS_SCRIPTS_DIR=/home/aberezovsky/workspace/cli-docs-scripts
CLI_SOURCE_DIR=/tmp/cf-cli-source
CLI_DOCS_PUBLIC_DIR=/tmp/cli-docs-public

function main() {
  read -p "==> Would you like to generate the docs with fly execute? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    rm -rf $CLI_DOCS_PUBLIC_DIR $CLI_SOURCE_DIR && mkdir -p $CLI_DOCS_PUBLIC_DIR $CLI_SOURCE_DIR
    fly -t ci execute \
      -c $CONCOURSE_SCRIPTS_DIR/pubtools/cf-CLI/publish-cf-cli-docs.yml \
      -i concourse-scripts=$CONCOURSE_SCRIPTS_DIR \
      -i cf-cli-source=$CLI_SOURCE_DIR \
      -i cli-docs-scripts=$CLI_DOCS_SCRIPTS_DIR \
      -o cli-docs-public=$CLI_DOCS_PUBLIC_DIR
  fi

  read -p "==> Would you like to push the docs to your configured cf? " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    cf push -f $CLI_DOCS_PUBLIC_DIR/staging.yml -p $CLI_DOCS_PUBLIC_DIR/public
  fi
}

main "$@"
