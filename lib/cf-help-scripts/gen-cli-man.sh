curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
./cf -v > cf-version.txt
./cf h | sed -n '/GETTING/,/ENVIRONMENT VARIABLES:/{/GETTING/b;/ENVIRONMENT VARIABLES:/b;p}' | sed -r '/.*:$/d;/^^$/d;s/   ([a-z-]+).*$/\1/' > cf-cmd-list.txt

export PATH=$PATH:.

LOCALE=en_US

TARGET_DIR=public/$LOCALE/cf
mkdir -p $TARGET_DIR

cp header.txt $TARGET_DIR/index.html

# set page language in <html> tag
sed -i -e "s/LOCALE/$LOCALE/i" $TARGET_DIR/index.html

LANG=$LOCALE cf -h >> $TARGET_DIR/index.html

sed -i -f cf-cmd-list.sed $TARGET_DIR/index.html

sed -i -e "s/CF_VERSION/`cat cf-version.txt`/i" $TARGET_DIR/index.html
