from datetime import datetime
from sys import argv
import pytz
hourlabel="hello"
timelabel="world"

dt = datetime.strptime(argv[1] + "+0000", "%Y%j%H%z").astimezone(pytz.timezone("US/Eastern"))

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
    <svg  version="1.1" id="Layer_1" 
  xml:space="preserve"
  xmlns="http://www.w3.org/2000/svg" 
  xmlns:xlink="http://www.w3.org/1999/xlink" width="500px" height="140px" viewbox="0 0 500 140">
        <text
            fill="white"
            transform="translate(480,70)"
            text-anchor="end"
            font-family="Franklin ITC Std"
            font-weight="bold"
            font-size="80">
            {hourlabel}
        </text>
        <text
            fill="white"
            transform="translate(490,130)"
            text-anchor="end"
            font-family="Franklin ITC Std"
            font-size="55">
            {timelabel}
        </text>
    </svg>'''

print(mobile_svg)
