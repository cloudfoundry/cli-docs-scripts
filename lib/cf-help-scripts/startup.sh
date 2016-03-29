set -ex

sh ./cf-cmd-list-all-langs.sh
cp cf-cli-refguide.css public
wget https://docs.cloudfoundry.org/images/favicon.ico -P public
