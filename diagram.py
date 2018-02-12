# -*- coding: utf-8 -*-

import SchemDraw as schem
import SchemDraw.elements as e

n = 3

d = schem.Drawing()
d.push()
d.add(e.LINE, l = n ** 2 + (n - 1) * 0.5, d = 'left')

L1 = d.add(e.LAMP, d = 'left', label = 'bulb')
V1 = d.add(e.SOURCE_V, d='left', reverse=True)
d.add(e.LINE, d='down', l = n)
last_point = d.add(e.DOT)
d.pop()
d.add(e.LINE, d='down', l = n)
d.add(e.DOT)
sw = d.add(e.LINE, d = 'left', l = 0.5)

def draw_series(Drawing, N):
    for i in range(1, N+1):
        Drawing.add(e.SWITCH_SPDT, d='left', flip = True)
        end = Drawing.add(e.LINE, d = 'left', l = 0.2)
    return(end.end)


def draw_sheet(Drawing, N, start = sw.end):
    for i in range(1, N+1):
        Drawing.add(e.LINE, d = 'down', xy = start, l = i)
        Drawing.add(e.LINE, d = 'left', l = 0.2)
        draw_series(Drawing, N)
    Drawing.add(e.LINE, d = 'up', l = N)

start = sw.end
for i in range(0, n):
    draw_sheet(d, n, start)
    start = d.add(e.LINE, d = 'left', l = 0.5).end

d.add(e.LINE, to = last_point.end)

d.draw()
d.save('images/schematic.png')
