#!/bin/bash

addfont() {
  local DST_DIR="/usr/local/share/fonts"

  local INPUT_FONT_DIR="$1"
  if [ ! -d "$INPUT_FONT_DIR" ]; then
    echo "Directory $INPUT_FONT_DIR DOES NOT exists."
    return 1
  fi
  
  local CLEANED_DIR=`echo "$INPUT_FONT_DIR" | sed -r -e "s/\/+$//g"`
  local FONT_FOLDER=`echo ${CLEANED_DIR##*/}`
  
  mv $CLEANED_DIR $DST_DIR
  chmod 755 ${DST_DIR}/${FONT_FOLDER}
  chmod 755 ${DST_DIR}/${FONT_FOLDER}/* -R
  fc-cache -fv

  echo "The font \"${FONT_FOLDER}\" is added in \"${DST_DIR}\"."
}

addfont $1
