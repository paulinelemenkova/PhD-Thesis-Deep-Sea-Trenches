#!/usr/bin/env python
# coding: utf-8
import numpy as np
import pandas as pd
import matplotlib.cm as cmx
import matplotlib.pylab as pylab
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.artist as martist
from matplotlib.offsetbox import AnchoredText
from matplotlib.colors import ListedColormap

df = pd.read_csv("Tab-Morph.csv")

params = {'figure.figsize': (10, 8),
    'figure.dpi': 300,
        'figure.titlesize': 14,
            'font.family': 'Palatino',
                'axes.labelsize': 8,
                    'axes.titlesize': 12,
                        'axes.titlepad': 1,
                            'axes.labelpad': .5,
                            }
pylab.rcParams.update(params)

def add_at(ax, t, loc=2):
    fp = dict(size=11)
    _at = AnchoredText(t, loc=loc, prop=fp)
    ax.add_artist(_at)
    return _at

fig = plt.figure()
fig.suptitle('3D correlation scatter plot, factors: \n sediment thickness, slope steepness, bathymetry (observation samples)',
             x=0.5, y=0.97)

# subplot 1
ax = fig.add_subplot(221, projection='3d')
ax.scatter(df.plate_pacif, df.sedim_thick, df.slope_angle,
           c='#ee827c', edgecolors='grey', s=130, alpha=.9)
ax.set_xlabel('Pacific Plate')
ax.set_ylabel('sediment thickness')
ax.set_zlabel('slope angle')
ax.view_init(30, 185)
plt.title('Pacific Plate')
add_at(ax, "A")

# subplot 2
ax = fig.add_subplot(222, projection='3d')
ax.scatter(df.plate_phill, df.sedim_thick, df.slope_angle,
           c='#f8b500', edgecolors='grey', s=130, alpha=.6)
ax.set_xlabel('Philippine Plate')
ax.set_ylabel('sediment thickness')
ax.set_zlabel('slope angle')
ax.view_init(30, 185)
plt.title('Phillipine Plate')
add_at(ax, "B")

# subplot 3
ax = fig.add_subplot(223, projection='3d')
ax.scatter(df.plate_carol, df.sedim_thick, df.slope_angle,
           c='#aacf53', edgecolors='grey', s=130, alpha=.8)
ax.set_xlabel('Caroline Plate')
ax.set_ylabel('sediment thickness')
ax.set_zlabel('slope angle')
ax.view_init(30, 185)
plt.title('Caroline Plate')
add_at(ax, "C")

# subplot 4
ax = fig.add_subplot(224, projection='3d')
ax.scatter(df.plate_maria, df.sedim_thick, df.slope_angle,
           c='#0095d9', edgecolors='grey', s=130, alpha=.7)
ax.set_xlabel('Mariana Plate')
ax.set_ylabel('sediment thickness')
ax.set_zlabel('slope angle')
ax.view_init(30, 185)
plt.title('Mariana Plate')
add_at(ax, "D")

plt.tight_layout()
plt.subplots_adjust(top=0.85, bottom=0.25,
                    left=0.10, right=0.95,
                    hspace=0.05, wspace=0.05
                    )
fig.savefig('plot_3DScat.png')
