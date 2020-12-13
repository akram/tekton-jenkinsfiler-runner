#!/bin/sh

PLUGINS_DIR=/usr/share/jenkins/ref/plugins/

chmod a+rw -R $PLUGINS_DIR
cd $PLUGINS_DIR
for FILE in *.*; do
  PLUGIN=${FILE%%.*}
  mkdir -p "$PLUGIN"
  (cd "$PLUGIN" && exec jar -xf "../$FILE")  
  echo $FILE  $PLUGIN
done

