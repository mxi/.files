#!/bin/sh

DISK_ICO=''
STATUS_LINE=$(df -Bh | awk '$6=="/"{print($5);}')

$PRINTF "$DWM_CLR_WHT$DISK_ICO %s$DWM_CLR_STD" "$STATUS_LINE"
