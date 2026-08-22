#!/bin/bash

FREE=$(df -H / | awk 'NR==2 {print $4}')

sketchybar --set "$NAME" label="${FREE}"
