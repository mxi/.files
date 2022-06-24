#!/bin/sh

DEV='/sys/class/power_supply/BAT0'
RATE=$(cat "$DEV/current_now")
[ "$RATE" -eq 0 ] && notify-send "Battery is fully charged" && exit

CHARGE=$(cat "$DEV/charge_now")
HOUR=$(( CHARGE / RATE ))
MIN=$(( 60 * CHARGE / RATE - 60 * HOUR ))

case $HOUR in
    0)
        case $MIN in
            0) notify-send "Battery fully charged" ;;
            1) notify-send "1 minute remaining" ;;
            *) notify-send "$MIN minutes remaining" ;;
        esac
        ;;
    1)
        case $MIN in
            0) notify-send "1 hour remaining" ;;
            1) notify-send "1 hour, 1 minute remaining" ;;
            *) notify-send "1 hour, $MIN minutes remaining" ;;
        esac
        ;;
    *)
        case $MIN in
            0) notify-send "$HOUR hours remaining" ;;
            1) notify-send "$HOUR hours, 1 minute remaining" ;;
            *) notify-send "$HOUR hours, $MIN minutes remaining" ;;
        esac
        ;;
esac
