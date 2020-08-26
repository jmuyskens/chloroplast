#!/bin/bash

# Jan. Feb., March, April, May, June, July, Aug., Sept., Oct., Nov. and Dec.

hourlabel=$(date -jnu -v -4H -f "%Y%j%H" $1 +"%-I %p")
timelabel=$(date -jnu -v -4H -f "%Y%j%H" $1 +"%b. %-d")
yearlabel=$(date -jnu -v -4H -f "%Y%j%H" $1 +"%Y")


hourlabel=`
    echo $hourlabel |
    sed "s/AM/a.m./" |
    sed "s/PM/p.m./"`


timelabel=`
    echo $timelabel |
    sed "s/AM/a.m./" |
    sed "s/PM/p.m./" |
    sed "s/Mar./March/" |
    sed "s/Apr./April/" |
    sed "s/May./May/" |
    sed "s/Jun./June/" |
    sed "s/Jul./July/" |
    sed "s/Sep/Sept/"`


# DESKTOP
echo "
    <svg width=\"500px\" height=\"100px\">
        <text
            fill=\"white\"
            transform=\"translate(500,35)\"
            text-anchor=\"end\"
            font-family=\"FranklinITCStd-Bold\"
            font-size=\"48\">
            ${hourlabel}
        </text>
        <text
            fill=\"white\"
            transform=\"translate(500,70)\"
            text-anchor=\"end\"
            font-family=\"FranklinITCStd-Light\"
            font-size=\"36\">
            ${timelabel}
        </text>
    </svg>" |
    cairosvg \
        - \
        -o $2

# MOBILE
echo "
    <svg width=\"500px\" height=\"140px\">
        <text
            fill=\"white\"
            transform=\"translate(490,70)\"
            text-anchor=\"end\"
            font-family=\"FranklinITCStd-Bold\"
            font-size=\"80\">
            ${hourlabel}
        </text>
        <text
            fill=\"white\"
            transform=\"translate(490,130)\"
            text-anchor=\"end\"
            font-family=\"FranklinITCStd-Light\"
            font-size=\"55\">
            ${timelabel}
        </text>
    </svg>" |
    cairosvg \
        - \
        -o $3
