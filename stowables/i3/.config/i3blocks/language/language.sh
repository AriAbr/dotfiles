#!/bin/bash

layout=$(setxkbmap -query | tail -1 | cut -d ":" -f2 | xargs)

echo ${layout^^} # Print in all uppercase
