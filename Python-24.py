from __future__ import print_function
%matplotlib inline
import os
import numpy as np
from scipy import stats
import pandas as pd
import matplotlib.pylab as pylab
import matplotlib.pyplot as plt
import matplotlib.artist as martist
from matplotlib.offsetbox import AnchoredText
import statsmodels.api as sm
from statsmodels.graphics.api import qqplot
import seaborn as sns

sns.set_style('darkgrid')

os.chdir('/Users/pauline/Documents/Python')
df = pd.read_csv("Tab-Morph.csv")

params = {'figure.figsize': (14, 7),
    'figure.dpi': 300,
        'figure.titlesize': 16,
            'font.family': 'Palatino',
                'axes.labelsize': 10,
                    'xtick.labelsize': 8,
                        'ytick.labelsize': 8,
                            'axes.labelpad':2,
                            }
pylab.rcParams.update(params)

def add_at(axes, t, loc=2):
    fp = dict(size=11)
    _at = AnchoredText(t, loc=loc, prop=fp)
    axes.add_artist(_at)
    return _at

fig, axes = plt.subplots(2, 3)

plt.suptitle('QQ statistics plots of the geology of the Mariana Trench',
             x=0.54, y=.92)

fig = qqplot(df.sedim_thick, line='q', fit=True,
             linewidth=.5, alpha = .5,
             markerfacecolor='#00a497', markeredgecolor='grey',
             ax=axes[0, 0])
add_at(axes[0, 0], "A")

fig = qqplot(df.slope_angle, line='q', fit=True,
             linewidth=.5, alpha = .5, markerfacecolor='#4d5aaf',
             markeredgecolor='grey', ax=axes[0, 1])
add_at(axes[0, 1], "B")

fig = qqplot(df.plate_pacif, line='q', fit=True,
             linewidth=.5, alpha = .4, markerfacecolor='#69821b',
             markeredgecolor='grey', ax=axes[0, 2])
add_at(axes[0, 2], "C")

fig = qqplot(df.plate_phill, line='q', fit=True,
             linewidth=.5, alpha = .4, markerfacecolor='#640125',
             markeredgecolor='grey', ax=axes[1, 0])
add_at(axes[1, 0], "D")

fig = qqplot(df.plate_maria, line='q', fit=True,
             linewidth=.1, alpha = .4, markerfacecolor='#b44c97',
             markeredgecolor='grey', ax=axes[1, 1])
add_at(axes[1, 1], "E")

fig = qqplot(df.igneous_volc, line='q',  fit=True,
             lw=.1, alpha = .4, markerfacecolor='#4d5aaf',
             markeredgecolor='grey', ax=axes[1, 2])
add_at(axes[1, 2], "F")

plt.show()
