#!/bin/bash

set -eu

CONCOURSE_SCRIPTS_DIR=/home/aberezovsky/workspace/concourse-scripts-docs
CLI_DOCS_SCRIPTS_DIR=/home/aberezovsky/workspace/cli-docs-scripts
CLI_RELEASE_DIR=/tmp/cf-cli-release
DOCS_CF_CLI=/home/aberezovsky/workspace/docs-cf-cli
OUT_DOCS_CF_CLI=/tmp/docs-cf-cli

DEFAULT_OUTFILE="cf-help.html.md.erb"

function main() {
  rm -rf $OUT_DOCS_CF_CLI && mkdir -p $OUT_DOCS_CF_CLI
  OUTFILE=${1:-$DEFAULT_OUTFILE} \
  fly -t ci execute \
    --include-ignored \
    -c $CONCOURSE_SCRIPTS_DIR/pubtools/cf-CLI/generate-cli-section-page.yml \
    -i concourse-scripts=$CONCOURSE_SCRIPTS_DIR \
    -i cf-cli-release=$CLI_RELEASE_DIR \
    -i cli-docs-scripts=$CLI_DOCS_SCRIPTS_DIR \
    -i docs-cf-cli-in=$DOCS_CF_CLI \
    -o docs-cf-cli-out=$OUT_DOCS_CF_CLI
}

main "$@"
