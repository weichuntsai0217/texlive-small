#!/bin/bash

txrun() {
  local TEX_EXT='tex'
  local AUX_EXT='aux'
  local DVI_EXT='dvi'
  local PDF_EXT='pdf'
  local LATEX='latex'
  local PDFLATEX='pdflatex' # If your tex file includes eps figs, please do NOT use pdflatex
  local XELATEX='xelatex'
  local ENGINE_RANGE="$LATEX $PDFLATEX $XELATEX"
  local DVIPDF='dvipdf'
  local BIBTEX='bibtex'
  local PTN_MAIN_FILE_NAME='s/\.[^.]*$//g'
  local PTN_SPACE_TO_COMMA="s/\ /', '/g"
  local ERR_PREFIX='[ERROR]'
  local INFO_PREFIX='[INFO]'

  local INPUT="$1"
  local ENGINE="$2"
  local TOT_POS_ARGS=2
  local OUTPUT_NAME=`echo $INPUT | sed -r "$PTN_MAIN_FILE_NAME"`

  _txrun_remove_derived_files_for_pdf() {
    local need_to_remove_exts_range="aux bbl blg idx ilg ind lof log lot out toc dvi"
    for ext in $need_to_remove_exts_range; do
      rm ${OUTPUT_NAME}.${ext} 2>/dev/null || true
    done
  }

  if [ $# -lt $TOT_POS_ARGS ]; then
    echo "$ERR_PREFIX The number of arguments is not enough."
    echo "Please provide 2 arguments. For example, 'txrun my_input.tex xelatex'"
    return 1
  fi

  local IS_ENGINE_VALID="false"
  for item in $ENGINE_RANGE; do
    if [ "$ENGINE" == "$item" ]; then
      IS_ENGINE_VALID="true"
      break
    fi
  done
  if [ "$IS_ENGINE_VALID" == "false" ]; then
    echo "$ERR_PREFIX The 2nd argument is invalid. It can only be one of '`echo $ENGINE_RANGE | sed -r "$PTN_SPACE_TO_COMMA"`'"
    echo "For example, 'txrun $INPUT xelatex'"
    return 1
  fi

  echo "$INFO_PREFIX If your input file includes 'eps' figures, please do NOT use 'pdflatex' as the 2nd argument."
  echo "$INFO_PREFIX Your input file is '$INPUT'"
  echo "$INFO_PREFIX The compile engine you choose is '$ENGINE'"
  echo "$INFO_PREFIX The output would be '${OUTPUT_NAME}.${PDF_EXT}'"
  _txrun_remove_derived_files_for_pdf
  $ENGINE $INPUT
  $BIBTEX ${OUTPUT_NAME}.${AUX_EXT}
  $ENGINE $INPUT
  $ENGINE $INPUT
  if [ "$ENGINE" == "$LATEX" ]; then
    $DVIPDF ${OUTPUT_NAME}.${DVI_EXT}
  fi
  _txrun_remove_derived_files_for_pdf

}

txrun $1 $2
