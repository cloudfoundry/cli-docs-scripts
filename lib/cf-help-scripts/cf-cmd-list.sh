#!/bin/bash

set -eu

main() {
  cli_binary="$1"
  locale="$2"

  if [ ! -x $cli_binary ]; then
    echo "Error: could not execute cli_binary"
    exit 1
  fi

  if [ -z $TARGET_DIR ]; then
    echo "Error: env TARGET_DIR required"
    exit 1
  fi

  cli_major_version="$($cli_binary -v | sed 's|cf [Vv]ersion \([[:digit:]]*\).*|\1|')"
  re='^[0-9]+$'
  if ! [[ $cli_major_version =~ $re ]] ; then
    echo "Error: cli_binary $cli_binary has a non integer major verison: $cli_major_version"
    exit 1
  fi

  cp header.txt $TARGET_DIR/index.html

  # set page language in <html> tag
  sed -i -e "s/LOCALE/$locale/i" $TARGET_DIR/index.html

  # make current locale the language menu title
  sed -i -e "s,\(li\)\(..a href.*$locale\),\1 id=\"current-lang\"\2,i" $TARGET_DIR/index.html

  $cli_binary config --locale $locale > /dev/null
  $cli_binary help -a >> $TARGET_DIR/index.html

  #apply various replacements, add footer
  sed -i -f cf-cmd-list.sed $TARGET_DIR/index.html

  # add separator between groups of commands in a section
  sed -i -e "/^$/ {N; s,<tr><td>,<tr class='separator'><td></td><td></td></tr>\n<tr><td>,g}" $TARGET_DIR/index.html

  sed -i -e "s/CF_VERSION/`cat cf-version.txt`/i" $TARGET_DIR/index.html

  sed -i -e "s/CLI_MAJOR_VERSION/v$cli_major_version/i" $TARGET_DIR/index.html
}

main "$@"
