#!/bin/sh

PLUGINS_DIR=/usr/share/jenkins/ref/plugins/

cd $PLUGINS_DIR
for FILE in *.*; do
  PLUGIN=${FILE%%.*}
  mkdir -p "$PLUGIN"
  (cd "$PLUGIN" && exec jar -xf "../$FILE")  
  echo $FILE  $PLUGIN
done

chown -R nobody /usr/share
chmod ugo+rwx -R /usr/share
