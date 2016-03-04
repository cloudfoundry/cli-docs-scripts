set -ex

if [ -n "${EDGE}" ]; then
  tar -zxf cf cf-cli-edge/cf-cli_edge_linux_x86-64.tgz
else
  curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&source=github" | tar -zx
fi

export PATH=.:$PATH

cf -v > cf-version.txt
cf h | sed -n '/GETTING/,/ENVIRONMENT VARIABLES:/{/GETTING/b;/ENVIRONMENT VARIABLES:/b;p}' | sed -r '/.*:$/d;/^^$/d;s/   ([a-z-]+).*$/\1/' > cf-cmd-list.txt

for LOCALE in `./cf config --locale DUMMY | tail -n+3 | tr _ -`; do
#for LOCALE in `echo en_US`; do

echo Processing language: $LOCALE

TARGET_DIR=public/$LOCALE/cf
mkdir -p $TARGET_DIR

./cf-cmd-list.sh $LOCALE
./cf-cmd-help-generate.sh $LOCALE

done
