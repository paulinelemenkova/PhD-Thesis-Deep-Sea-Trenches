#!/usr/bin/env python
# coding: utf-8
%matplotlib inline
import os
import pandas as pd
import matplotlib.pylab as pylab
from matplotlib import pyplot as plt
import seaborn as sb

sb.set_style('darkgrid')
sb.set_context('paper')

params = {'font.family': 'Palatino',
    'axes.labelsize': 8,
        'lines.linewidth': .2,
            'xtick.major.size': 4,
                'xtick.labelsize': 8,
                    'figure.titlesize': 8,
                        'figure.dpi': 300,
                        }
pylab.rcParams.update(params)

# loading data
os.chdir('/Users/pauline/Documents/Python')
dfM = pd.read_csv("Tab-Bathy.csv")
dfM.head(5)

# plotting
g = sb.catplot(data=dfM, kind="violin", scale='count', palette="Paired",
               orient="v", margin_titles=True)
g.fig.set_size_inches(10, 5)

plt.xticks(rotation=45)
plt.title('Violin plots for the Mariana Trench bathymetry')
plt.subplots_adjust(bottom=0.15,top=0.85)

# visualizing
plt.tight_layout()
plt.savefig('plot_Viol.png')
plt.show()
