#!/usr/bin/env python
# coding: utf-8
import os
import pandas as pd
from matplotlib import pyplot as plt
import seaborn as sb

sb.set(style = "white")
sb.set_context('paper')
sb.set_color_codes()
os.chdir('/Users/pauline/Documents/Python')

# defining a loop
profiles_nrs = list(map(lambda x: x, range(25)))
profiles_list = []
for i in profiles_nrs:
    profiles_list.append('profile{}'.format(i + 1))

# generating data frame
dfB = pd.read_csv("Tab-Bathy.csv")
df = dfB.melt(id_vars=['observ'],
              value_vars=profiles_list,
              var_name='Profiles', value_name='Depths'
              )
# plotting
sb.jointplot(x='observ', y='Depths', data=df,
             kind='kde', dropna=True, color="m"
             )
sb.jointplot(x="observ", y="Depths", data=df,
             kind="hex", dropna=True
             )
plt.subplots_adjust(bottom=0.15,top=0.85, right=0.90, left=0.10)

# visualizing
plt.tight_layout()
plt.savefig('plot_Hexbin.png', dpi=300)
plt.show()
