LOCALE=$1
if [ -z "$1" ]
  then
    LOCALE=en_US
fi

TARGET_DIR=public/$LOCALE/cf
mkdir -p $TARGET_DIR

for CMD in `cat cf-cmd-list.txt`; do

cp header.txt $TARGET_DIR/$CMD.html

#set page language in <html> tag
sed -i -e "s,LOCALE,$LOCALE,g" $TARGET_DIR/$CMD.html

# make current locale the language menu title
sed -i -e "s,\(li\)\(..a href.*$LOCALE\),\1 id=\"current-lang\"\2,i" $TARGET_DIR/$CMD.html

#update link for other languages to this command
sed -i -e "s,cf\"\(\">\w\),cf/$CMD.html\1,i" $TARGET_DIR/$CMD.html

#revert the one for Home
sed -i -e "s,$LOCALE/cf/$CMD.html,$LOCALE/cf/index.html,i" $TARGET_DIR/$CMD.html
#sed -i -e "s,/\(<li>.*/cf\)/$CMD.html,\1/index.html,i" $TARGET_DIR/$CMD.html

#insert command name into title
sed -i -e "s/title>/\0$CMD - /i" $TARGET_DIR/$CMD.html

#insert command name into page header
sed -i -e "s/h1>/\0$CMD - /i" $TARGET_DIR/$CMD.html

LANG=$LOCALE cf h $CMD > $TARGET_DIR/$CMD.txt

#HTML escape <>&"
sed -e "s,\&,\&amp;,g; s,<,\&lt;,g; s,>,\&gt;,g;" $TARGET_DIR/$CMD.txt >> $TARGET_DIR/$CMD.html

#apply various replacements
sed -i -f cf-cmd-help-generate.sed $TARGET_DIR/$CMD.html

#sed -i -e "/^   cf \w.+/{N; s/^   cf \w.+.*\n\n/<code>\0<\/code>/g}" $TARGET_DIR/$CMD.html

#make multiline usage into one
sed -i -e "/<\/code>$/ {N; s/<\/code>\n<code>   \[-/ \[-/g}" $TARGET_DIR/$CMD.html
sed -i -e "/<\/code>$/ {N; s/<\/code>\n<code>   \[-/ \[-/g}" $TARGET_DIR/$CMD.html

#indented platform specific examples (see create-service)
sed -i -e "s/^      cf $CMD.*/<div class=\"syntax\"><pre>\0<\/pre><\/div>/g" $TARGET_DIR/$CMD.html

#bold cf command
sed -i -e "s,cf $CMD,<b>\0</b>,g" $TARGET_DIR/$CMD.html

sed -i -e "s/CF_VERSION/`cat cf-version.txt`/i" $TARGET_DIR/$CMD.html

done
