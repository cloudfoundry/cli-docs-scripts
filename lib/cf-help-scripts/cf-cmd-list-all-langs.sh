set -e

export PATH=.:$PATH

generate_docs_for_cf() {
  cf_binary=$1
  cf_binary_version="$($cf_binary -v | sed 's|cf version \([[:digit:]]*\).*|\1|')"

  $cf_binary config --color false
  $cf_binary -v > cf-version.txt
  # search for, then print range from GETTING to VARIABLES | delete section headers (lines ending with ':') ; delete empty lines ; remove whitespace and text around command
  $cf_binary h -a | sed -n '/GETTING/,/ENVIRONMENT VARIABLES:/{/GETTING/b;/ENVIRONMENT VARIABLES:/b;p}' | sed -r '/.*:$/d;/^^$/d;s/   ([a-z-]+).*$/\1/' | sed '/.?*\:/d' > cf-cmd-list.txt
  $cf_binary h -a | sed -n '/experimental/,${/experimental/b;;p}' | sed -r '/.*:$/d;/^^$/d;s/   ([a-z0-9-]+) .*$/\1/'  >> cf-cmd-list.txt

  for LOCALE in de-DE en-US es-ES fr-FR it-IT ja-JP ko-KR pt-BR zh-Hans zh-Hant; do
    #Non-programmer replaces the following with the above: for LOCALE in `./cf config --locale DUMMY | tail -n+3 | tr _ -`; do
    #for LOCALE in `echo en_US`; do

    echo Processing language: $LOCALE

    export TARGET_DIR=public/$LOCALE/v${cf_binary_version}
    mkdir -p $TARGET_DIR

    ./cf-cmd-list.sh $cf_binary $LOCALE &> /tmp/docs.log
    ./cf-cmd-help-generate.sh $cf_binary $LOCALE &> /tmp/docs.log
  done
}

main() {
  curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github&version=v6" | tar -zx
  generate_docs_for_cf "$(pwd)/cf"

  # TODO: handle errors with curl
  curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github&version=v7" | tar -zx
  generate_docs_for_cf "$(pwd)/cf"
}

main "$@"
