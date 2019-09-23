#!/usr/bin/env python
# coding: utf-8
import os
import pandas as pd
import numpy as np
from matplotlib import pyplot as plt

os.chdir('/Users/pauline/Documents/Python')
dfM = pd.read_csv("Tab-Morph.csv")

# dataset
df = pd.DataFrame({'Pacific Plate':dfM.plate_pacif,
                  'Philippine Plate':dfM.plate_phill,
                  'Mariana Plate':dfM.plate_maria,
                  'Caroline Plate':dfM.plate_carol},
                  index=dfM.profile)

# plot chart
df.plot(kind='pie', subplots=True, figsize=(10, 10),
        legend=False, table=False,
        fontsize=8, sort_columns=True,
        layout=(2, 2), colormap='tab20b',
        title='Mariana Trench: Pie charts for the \nsample points distribution by tectonic plates',
        )

# visualize and save
plt.tight_layout()
plt.savefig('plot_Pie.png', dpi=300)
plt.show()

