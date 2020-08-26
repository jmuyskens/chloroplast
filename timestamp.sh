#!/bin/bash
yeardoyhour=$1

# DESKTOP
python timestampsvg.py $yeardoyhour |
    cairosvg \
        - \
        -o $2
