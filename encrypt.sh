#!/bin/bash

# first, get uuid
uuid=$(cat /proc/sys/kernel/random/uuid)

private_key_path="./pair.private.key"
public_key_path="./pair.public.key"
# now we have keys

sleep 1
# now lets copy whats in text box to clipboard
xte 'keydown Control_L' 'key a' 'key c' 'keyup Control_L' 'key BackSpace'
sleep 0.2
clipboard=$(xclip -selection clipboard -o)
echo "Clipboard: ${clipboard}"

encrypted=$(ntru encrypt ${public_key_path} "${clipboard}")

# now we will print the result
echo -n ${encrypted} | xclip -selection clipboard

sleep 0.2
# finally, paste
xte 'keydown Control_L' 'key v' 'keyup Control_L'