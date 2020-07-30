set -ex

CF_BINARY=$1

LOCALE=$2
if [ -z "$LOCALE" ]; then
  LOCALE=en-US
fi

for CMD in `cat cf-cmd-list.txt`; do
  cp header.txt $TARGET_DIR/$CMD.html

  #set page language in <html> tag
  sed -i -e "s,LOCALE,$LOCALE,g" $TARGET_DIR/$CMD.html

  # make current locale the language menu title
  sed -i -e "s,\(li\)\(..a href.*$LOCALE\),\1 id=\"current-lang\"\2,i" $TARGET_DIR/$CMD.html

  #update link for other languages to this command
  sed -i -e "s,\(^<li.*cf\)\",\1/$CMD.html\",i" $TARGET_DIR/$CMD.html

  #insert command name into title
  sed -i -e "s/title>/\0$CMD - /i" $TARGET_DIR/$CMD.html

  #insert command name into page header
  sed -i -e "s/h1>/\0$CMD - /i" $TARGET_DIR/$CMD.html

  $CF_BINARY config --locale $LOCALE
  $CF_BINARY help $CMD > $TARGET_DIR/$CMD.txt

  #HTML escape <>&"
  sed -e "s,\&,\&amp;,g; s,<,\&lt;,g; s,>,\&gt;,g;" $TARGET_DIR/$CMD.txt >> $TARGET_DIR/$CMD.html

  #apply various replacements, add footer
  sed -i -f cf-cmd-help-generate.sed $TARGET_DIR/$CMD.html

  #sed -i -e "/^   cf \w.+/{N; s/^   cf \w.+.*\n\n/<code>\0<\/code>/g}" $TARGET_DIR/$CMD.html

  #make multiline usage into one
  sed -i -e "/<\/code>$/ {N; s/<\/code>\n<code>   \[-/ \[-/g}" $TARGET_DIR/$CMD.html
  sed -i -e "/<\/code>$/ {N; s/<\/code>\n<code>   \[-/ \[-/g}" $TARGET_DIR/$CMD.html

  #bold cf command
  sed -i -e "s,cf $CMD,<b>\0</b>,g" $TARGET_DIR/$CMD.html

  sed -i -e "s/CF_VERSION/`cat cf-version.txt`/i" $TARGET_DIR/$CMD.html
done
