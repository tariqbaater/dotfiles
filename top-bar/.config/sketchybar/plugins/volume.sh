#!/usr/bin/env zsh

case ${INFO} in
0)
    ICON="􀊢"
    ICON_PADDING_RIGHT=6
    sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT label="" # Mute when volume is 0%
    ;;
[1-4][0-9]|50)
    ICON="􀊦"
    ICON_PADDING_RIGHT=8
    ;;
[5-9][0-9]|100)
    ICON="􀊨"
    ICON_PADDING_RIGHT=10
    ;;
*)
    ICON="􀊦"
    ICON_PADDING_RIGHT=10
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT label="$INFO%"
