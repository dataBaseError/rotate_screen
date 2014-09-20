#!/bin/bash
# This script rotates the screen and touchscreen input 180 degrees, disables the touchpad, and enables the virtual keyboard
# And rotates screen back if the touchpad was disabled

CONFIG_FILE=.rotate_confg

if [ -n "$ROTATE"] ; then
    if [ -e ~/${CONFIG_FILE} ]; then
        echo "READING IN value"
        ROTATE=`cat ~/.rotate_confg`
    else
        ROTATE=1
    fi
fi

echo $ROTATE

#isEnabled=$(xinput --list-props 'SynPS/2 Synaptics TouchPad' | awk '/Device Enabled/{print $NF}')

if [ $ROTATE -gt 0 ]; then

    echo $ROTATE
    
    if [ $ROTATE -eq 1 ]; then
        echo "Screen is turned upside down"
        xrandr -o inverted

        xinput set-prop 'Wacom ISDv4 E6 Pen stylus' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1

        xinput set-prop 'Wacom ISDv4 E6 Pen eraser' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1

        xinput set-prop 'Wacom ISDv4 E6 Finger touch' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
    elif [ $ROTATE -eq 2 ]; then
        echo "Screen is rotated 90 degrees clockwise"
        xrandr -o left

        xinput set-prop 'Wacom ISDv4 E6 Pen stylus' 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1

        xinput set-prop 'Wacom ISDv4 E6 Pen eraser' 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1

        xinput set-prop 'Wacom ISDv4 E6 Finger touch' 'Coordinate Transformation Matrix' 0 -1 1 1 0 0 0 0 1
    elif [ $ROTATE -eq 3 ]; then 
        echo "Screen is rotated 90 degrees counter-clockwise"
        xrandr -o right

        xinput set-prop 'Wacom ISDv4 E6 Pen stylus' 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1

        xinput set-prop 'Wacom ISDv4 E6 Pen eraser' 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1

        xinput set-prop 'Wacom ISDv4 E6 Finger touch' 'Coordinate Transformation Matrix' 0 1 0 -1 0 1 0 0 1
    fi

    ROTATE=$(($ROTATE+1))

    echo $ROTATE

    if [ $ROTATE -gt 3 ]; then
        ROTATE=0
    fi

    xinput disable 'SynPS/2 Synaptics TouchPad'
    xinput disable 'TPPS/2 IBM TrackPoint'
    # Remove hashtag below if you want pop-up the virtual keyboard  
    # onboard &
else
    echo "Screen is turned back to normal"
    xrandr -o normal

    xinput set-prop 'Wacom ISDv4 E6 Pen stylus' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1

    xinput set-prop 'Wacom ISDv4 E6 Pen eraser' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1

    xinput set-prop 'Wacom ISDv4 E6 Finger touch' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    xinput enable 'SynPS/2 Synaptics TouchPad'
    xinput enable 'TPPS/2 IBM TrackPoint'
    # killall onboard 
    ROTATE=$(($ROTATE+1))
fi

echo $ROTATE > ~/${CONFIG_FILE}
