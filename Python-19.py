#!/usr/bin/env python
# coding: utf-8
import os
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib import rc

os.chdir('/Users/pauline/Documents/Python')
df = pd.read_csv("Tab-Morph.csv")

bars1 = df.plate_phill
bars2 = df.plate_pacif
bars3 = df.plate_maria
bars4 = df.plate_carol

# position of the bars on the x-axis
profiles = df.profile

# generate a loop for 25 profiles
names = range(1, 26)

# plotting
barWidth = 1
ax = plt.subplot(111)
plt.bar(profiles, bars1, color='#dbd0e6', edgecolor='white',
        width=barWidth, label='Philippine Plate')
plt.bar(profiles, bars2, bottom=(bars1), color='#a0d8ef',
        edgecolor='white', width=barWidth,
        label='Pacific Plate')
plt.bar(profiles, bars3, bottom=(bars1 + bars2), color='#eebbcb',
        edgecolor='white', width=barWidth,
        label='Mariana Plate')
plt.bar(profiles, bars4, bottom=(bars1 + bars2 + bars3), color='#c1d8ac',
        edgecolor='white', width=barWidth,
        label='Caroline Plate')

# Custom X axis
plt.xticks(profiles, names, fontweight='normal', fontsize=7, rotation=30)

# Show graphic
plt.legend()
ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.10),
          shadow=True, markerscale=2, ncol=4, fontsize=6, title=False)
ax.set_xlabel('Profiles (1:25)', fontsize=10)
ax.set_ylabel('Observations (1:518)', fontsize=10)
plt.title('Mariana Trench: Stacked barplots for the distribution \nof the bathymetric observations across tectonic plates',
          fontsize=10, fontfamily='sans-serif')

# visualize and save
plt.tight_layout()
plt.savefig('plot_StackBar.png', dpi=300)
plt.show()
