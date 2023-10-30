#!/bin/bash

sleep 0.5

# draw a regular polygon with mouse using xte
side_count=20
radius=50
delay=0.1

# Calculate the angle between each side in radians
angle_increment=$(awk "BEGIN {print (2*3.14159)/$side_count}")

# Begin drawing at starting position
x_prev=$(awk "BEGIN {print $radius*sin(0)}")
y_prev=$(awk "BEGIN {print -$radius*cos(0)}")
x_mr=$(printf "%.0f" $x_prev)
y_mr=$(printf "%.0f" $y_prev)
xte "mousermove $x_mr $y_mr"
xte 'mousedown 1'

for ((i=1; i<=$side_count; i++)); do
    angle=$(awk "BEGIN {print $i*$angle_increment}")
    x=$(awk "BEGIN {print $radius*sin($angle)}")
    y=$(awk "BEGIN {print -$radius*cos($angle)}")
    x_rounded=$(printf "%.0f" $x)
    y_rounded=$(printf "%.0f" $y)

    # Calculate the relative move to the next vertex
    dx=$(printf "%.0f" $(echo "$x - $x_prev" | bc))
    dy=$(printf "%.0f" $(echo "$y - $y_prev" | bc))

    # Update previous x, y coordinates
    x_prev=$x
    y_prev=$y

    # Move mouse to next vertex
    xte "mousermove $dx $dy"
    sleep $delay
done

xte 'mouseup 1'