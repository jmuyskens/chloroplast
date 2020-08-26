from datetime import datetime
from sys import argv
hourlabel="hello"
timelabel="world"

dt = datetime.strptime(argv[1], "%Y%j%H")

hourlabel = dt.strftime("%-I %p") \
    .replace('AM', 'a.m.') \
    .replace('PM', 'p.m.')

timelabel = dt.strftime("%b. %-d")

desktop_svg = f'''
    <svg width="500px" height="100px">
        <text
            fill="white"
            transform="translate(500,35)"
            text-anchor="end"
            font-family="FranklinITCStd-Bold"
            font-size="48">
            {hourlabel}
        </text>
        <text
            fill="white"
            transform="translate(500,70)"
            text-anchor="end"
            font-family="FranklinITCStd-Light"
            font-size="36">
            {timelabel}
        </text>
    </svg>'''

mobile_svg = f'''
    <svg width="500px" height="140px">
        <text
            fill="white"
            transform="translate(490,70)"
            text-anchor="end"
            font-family="FranklinITCStd-Bold"
            font-size="80">
            {hourlabel}
        </text>
        <text
            fill="white"
            transform="translate(490,130)"
            text-anchor="end"
            font-family="FranklinITCStd-Light"
            font-size="55">
            {timelabel}
        </text>
    </svg>'''

print(mobile_svg)
