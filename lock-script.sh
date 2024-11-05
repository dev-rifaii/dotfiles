#!/usr/bin/env bash

rm -f /tmp/screenshot.png
rm -f /tmp/screenshotblur.png

scrot /tmp/screenshot.png

magick /tmp/screenshot.png -blur 0x9 /tmp/screenshotblur.png

i3lock -i /tmp/screenshotblur.png
