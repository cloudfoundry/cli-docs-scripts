#!/bin/bash

set -eu

export PATH=.:$PATH
LOCALES="de-DE en-US es-ES fr-FR it-IT ja-JP ko-KR pt-BR zh-Hans zh-Hant"

generate_docs_for_cf() {
  cli_binary=$1

  cli_major_version="$($cli_binary -v | sed 's|cf version \([[:digit:]]*\).*|\1|')"
  re='^[0-9]+$'
  if ! [[ $cli_major_version =~ $re ]]; then
    echo "error: cli_binary $cli_binary has a non integer major verison: $cli_major_version"
    exit 1
  fi

  $cli_binary config --color false > /dev/null
  $cli_binary -v > cf-version.txt

  # search for, then print range from GETTING to VARIABLES | delete section headers (lines ending with ':') ; delete empty lines ; remove whitespace and text around command
  $cli_binary h -a | sed -n '/GETTING/,/ENVIRONMENT VARIABLES:/{/GETTING/b;/ENVIRONMENT VARIABLES:/b;p}' | sed -r '/.*:$/d;/^^$/d;s/   ([a-z-]+).*$/\1/' | sed '/.?*\:/d' > cf-cmd-list.txt
  $cli_binary h -a | sed -n '/experimental/,${/experimental/b;;p}' | sed -r '/.*:$/d;/^^$/d;s/   ([a-z0-9-]+) .*$/\1/'  >> cf-cmd-list.txt

  for locale in $LOCALES; do
    echo "Processing language: $locale, binary version: v$cli_major_version"

    export TARGET_DIR=public/$locale/v$cli_major_version
    mkdir -p $TARGET_DIR

    ./cf-cmd-list.sh $cli_binary $cli_major_version $locale
    ./cf-cmd-help-generate.sh $cli_binary $cli_major_version $locale
  done
}

clean_up_cli(){
  rm -rf ~/.cf/config.json
}

main() {
  MAJOR_VERSIONS="6 7 8"

  for version in $MAJOR_VERSIONS; do
    url="$CLAW_URL/stable?release=linux64-binary&source=github&version=v$version"
    echo "Pulling cf cli binary from: $url"
    curl -sLk $url | tar -zx
    cli_binary="$(pwd)/cf"

    if [ -x "$cli_binary" ]; then
      generate_docs_for_cf "$cli_binary"
    else
      echo "Error: could not download v$version CLI"
      exit 1
    fi

    clean_up_cli
  done
}

main "$@"
