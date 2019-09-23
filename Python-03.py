#!/usr/bin/env python
# coding: utf-8
import os
import pandas as pd
from matplotlib import pyplot as plt
import matplotlib.artist as martist
from matplotlib.offsetbox import AnchoredText
import seaborn as sb

sb.set_style("whitegrid")
sb.set_context("paper")
sb.set_color_codes()

os.chdir('/Users/pauline/Documents/Python')
dfM = pd.read_csv("Tab-Morph.csv")

fig = plt.figure(figsize=(10.0, 6.0), dpi=300)
fig.suptitle('Histogram plot of the observation sample distribution',
             fontsize=10, fontweight='bold', x=0.5, y=0.99
             )

def add_at(ax, t, loc=2):
    fp = dict(size=11)
    _at = AnchoredText(t, loc=loc, prop=fp)
    ax.add_artist(_at)
    return _at

# subplot 1
ax = fig.add_subplot(221)
sb.distplot(dfM['plate_maria'], kde=True, rug=True, hist=True,
            norm_hist=True, color="xkcd:periwinkle blue",
            axlabel='Mariana Plate observations',
            label='Mariana Plate', vertical=False
            )
add_at(ax, "A")

# subplot 2
ax = fig.add_subplot(222)
sb.distplot(dfM['plate_pacif'], kde=True, rug=True, hist=True,
            norm_hist=True, color="xkcd:aqua",
            axlabel='Pacific Plate observations',
            label='Pacific Plate', vertical=False
            )
add_at(ax, "B")

# subplot 3
ax = fig.add_subplot(223)
sb.distplot(dfM['plate_carol'], kde=True, rug=True, hist=True,
            norm_hist=True, color="xkcd:pale violet",
            axlabel='Caroline Plate observations',
            label='Caroline Plate', vertical=False
            )
add_at(ax, "C")

# subplot 4
ax = fig.add_subplot(224)
sb.distplot(dfM['plate_phill'],kde=True, rug=True, hist=True,
            norm_hist=True, color="xkcd:rose pink",
            axlabel='Philippine Plate observations',
            label='Philippine Plate', vertical=False
            )
add_at(ax, "D")

# visualize
plt.tight_layout()
plt.subplots_adjust(top=0.92, bottom=0.08,
                    left=0.10, right=0.95,
                    hspace=0.25, wspace=0.35
                    )
fig.savefig('plot_Hist.png', dpi=300)
plt.show()
