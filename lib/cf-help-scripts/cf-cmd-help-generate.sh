#!/bin/bash

set -eu

main() {
  cli_binary="$1"
  cli_major_version="$2"
  locale="$3"

  if [ ! -x $cli_binary ]; then
    echo "Error: could not execute cli_binary"
    exit 1
  fi

  if [ -z $TARGET_DIR ]; then
    echo "Error: env TARGET_DIR required"
    exit 1
  fi

  re='^[0-9]+$'
  if ! [[ $cli_major_version =~ $re ]] ; then
    echo "Error: cli_binary $cli_binary has a non integer major verison: $cli_major_version"
    exit 1
  fi

  for cmd in `cat cf-cmd-list.txt`; do
    cp header-for-command.txt $TARGET_DIR/$cmd.html

    #set page language in <html> tag
    sed -i -e "s,LOCALE,$locale,g" $TARGET_DIR/$cmd.html

    # make current locale the language menu title
    sed -i -e "s,\(li\)\(..a href.*$locale/CLI_MAJOR_VERSION\),\1 id=\"current-lang\"\2,i" $TARGET_DIR/$cmd.html

    # make current version the version menu title
    sed -i -e "s,\(li\)\(..a href.*v$cli_major_version\),\1 id=\"current-lang\"\2,i" $TARGET_DIR/$cmd.html

    #update link for other languages to this command
    sed -i -e "s,\(^<li.*cf\)\",\1/$cmd.html\",i" $TARGET_DIR/$cmd.html

    #insert command name into title
    sed -i -e "s/title>/\0$cmd - /i" $TARGET_DIR/$cmd.html

    #insert command name into page header
    sed -i -e "s/h1>/\0$cmd - /i" $TARGET_DIR/$cmd.html

    $cli_binary config --locale $locale > /dev/null
    $cli_binary help $cmd > $TARGET_DIR/$cmd.txt

    #HTML escape <>&"
    sed -e "s,\&,\&amp;,g; s,<,\&lt;,g; s,>,\&gt;,g;" $TARGET_DIR/$cmd.txt >> $TARGET_DIR/$cmd.html

    #apply various replacements, add footer
    sed -i -f cf-cmd-help-generate.sed $TARGET_DIR/$cmd.html

    #make multiline usage into one
    sed -i -e "/<\/code>$/ {N; s/<\/code>\n<code>   \[-/ \[-/g}" $TARGET_DIR/$cmd.html
    sed -i -e "/<\/code>$/ {N; s/<\/code>\n<code>   \[-/ \[-/g}" $TARGET_DIR/$cmd.html

    #bold cf command
    sed -i -e "s,cf $cmd,<b>\0</b>,g" $TARGET_DIR/$cmd.html

    sed -i -e "s/CF_VERSION/`cat cf-version.txt`/i" $TARGET_DIR/$cmd.html

    sed -i -e "s/CLI_MAJOR_VERSION/v$cli_major_version/i" $TARGET_DIR/$cmd.html

    sed -i -e "s/CMD/$cmd/i" $TARGET_DIR/$cmd.html
  done
}

main "$@"

