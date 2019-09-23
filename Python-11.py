#!/usr/bin/env python
# coding: utf-8
import os
import pandas as pd
import seaborn as sb
from matplotlib import pyplot as plt

sb.set_style('whitegrid')
sb.set_context('paper')

os.chdir('/Users/pauline/Documents/Python')
dfB = pd.read_csv("Tab-Bathy.csv")

# define variables and plotting
sb.boxplot(data=dfB, orient="v", palette='coolwarm', saturation=1,
           width=0.8, dodge=True, fliersize=5, linewidth=0.2,
           whis=5, notch=True, ax=None
           )
sb.despine(offset=10, trim=True) # offset the spines away from the sample data
plt.xticks(rotation=45)
plt.yticks(rotation=45)
plt.title('Box-and-whisker plot for the Mariana Trench bathymetry',
          fontsize=12, fontfamily='sans-serif'
          )

# printing and saving
plt.tight_layout()
plt.savefig('plot_Boxplot.png', dpi=300)
plt.show()
