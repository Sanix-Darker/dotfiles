#/bin/bash

# our colors
BLANK='#00000000'
CLEAR='#ffffff22'
DEFAULT='#8800FF'
TEXT='#8800FF'
WRONG='#880000'
VERIFYING='#bb00bb'
KEYDOWN='#28FF49'

# we run the i3lock if i3lock is installed
$(command -v i3lock > /dev/null) &&\
    [[ $? == 0 ]] && i3lock \
    --insidever-color=$CLEAR     \
    --ringver-color=$VERIFYING   \
    --insidewrong-color=$CLEAR   \
    --ringwrong-color=$WRONG     \
    --inside-color=$BLANK        \
    --ring-color=$DEFAULT        \
    --line-color=$BLANK          \
    --separator-color=$DEFAULT   \
    --verif-color=$TEXT          \
    --wrong-color=$TEXT          \
    --time-color=$TEXT           \
    --date-color=$TEXT           \
    --layout-color=$TEXT         \
    --keyhl-color=$KEYDOWN       \
    --bshl-color=$WRONG          \
    --screen 1                   \
    --blur 7                     \
    --clock                      \
    --time-str="%H:%M:%S"        \
    --keylayout
