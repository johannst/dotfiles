#!/bin/bash
# dotfiles -- scripts/backlight.sh
# author: johannst

case $BLOCK_BUTTON in
  3) xbacklight -set 100;; # right click, set default
  4) xbacklight -inc 10 ;; # scroll up, inc brightness
  5) xbacklight -dec 10 ;; # scroll down, dec brightness
esac

BACKLIGHT=$(xbacklight -get | awk -F . '{ printf $1 }')

echo "${BACKLIGHT}%"
