# #!/bin/sh
#
# # The volume_change event supplies a $INFO variable in which the current volume
# # percentage is passed to the script.
#
# if [ "$SENDER" = "volume_change" ]; then
#   VOLUME="$INFO"
#
#   case "$VOLUME" in
#     [6-9][0-9]|100) ICON="󰕾"
#     ;;
#     [3-5][0-9]) ICON="󰖀"
#     ;;
#     [1-9]|[1-2][0-9]) ICON="󰕿"
#     ;;
#     *) ICON="󰖁"
#   esac
#
#   sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
#!/usr/bin/env zsh

case ${INFO} in
0)
    ICON=""
    ICON_PADDING_RIGHT=21
    ;;
[0-9])
    ICON=""
    ICON_PADDING_RIGHT=12
    ;;
*)
    ICON=""
    ICON_PADDING_RIGHT=6
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT label="$INFO%" fi
