set -ex

CF_BINARY=$1
if [ -z "$CF_BINARY" ]; then
  echo "CF_BINARY required"
  exit 1
fi

CF_BINARY_VERSION="$($CF_BINARY -v | sed 's|cf version \([[:digit:]]*\).*|\1|')"

LOCALE=$2
if [ -z "$LOCALE" ]; then
  LOCALE=en-US
fi

cp header.txt $TARGET_DIR/index.html

# set page language in <html> tag
sed -i -e "s/LOCALE/$LOCALE/i" $TARGET_DIR/index.html

# make current locale the language menu title
sed -i -e "s,\(li\)\(..a href.*$LOCALE\),\1 id=\"current-lang\"\2,i" $TARGET_DIR/index.html

$CF_BINARY config --locale $LOCALE
$CF_BINARY help -a >> $TARGET_DIR/index.html

#apply various replacements, add footer
sed -i -f cf-cmd-list.sed $TARGET_DIR/index.html

# add separator between groups of commands in a section
sed -i -e "/^$/ {N; s,<tr><td>,<tr class='separator'><td></td><td></td></tr>\n<tr><td>,g}" $TARGET_DIR/index.html

sed -i -e "s/CF_VERSION/`cat cf-version.txt`/i" $TARGET_DIR/index.html
