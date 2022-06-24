#!/bin/sh

PERCENT=$("$SCRIPT_HOME/brightness-get.sh")

THR_DIM=25
ICO_DIM=''
ICO=''
[ $PERCENT -le $THR_DIM ] && ICO=$ICO_DIM

$PRINTF "$DWM_CLR_WHT$ICO %d%%$DWM_CLR_STD" "$PERCENT"
