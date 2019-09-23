#!/usr/bin/env python
# coding: utf-8
from matplotlib import pyplot as plt
from matplotlib import cm
from matplotlib_venn import venn2, venn2_circles, venn3, venn3_circles

figure, axes = plt.subplots(2, 2, figsize=(7, 7), dpi=300)

bbox_props = dict(boxstyle='round, pad=0.3', fc='w',
                  edgecolor='grey', linewidth=1, alpha=0.9)

venn3(subsets=(6317, 3552, 2949, 0, 0, 0, 132),
      ax=axes[0][0], alpha = .3,
      set_colors=('blue','lightblue', 'green'),
      set_labels = ('Philippine', 'Mariana', 'Pacific', 'Caroline'))
plt.annotate('Caroline', xy=(-0.6, 1.3),
             xycoords="axes fraction", fontsize=12)
plt.annotate('A', xy=(-1.55, 2.4),
             xycoords="axes fraction",
             fontsize=12, bbox=bbox_props)

venn3(subsets=(1086, 2801, 1550, 0, 0, 2293, 4883),
      set_labels = ('Sediment \nthickness', 'Slope angle', 'Igneous \nvolcanic spots'),
      set_colors=('#a59aca','#e45e32', '#aacf53'),
      alpha = .7, ax=axes[0][1])
plt.annotate('B', xy=(-0.05, 2.4),
             xycoords="axes fraction",
             fontsize=12, bbox=bbox_props)

venn3(subsets=(4, 1, 6, 6, 4, 5, 1),
      set_labels = ('Strong \nSlope', 'Extreme \nSlope', 'Steep Slope'),
      set_colors=('#98d98e','#d9333f', '#ffd900'),
      alpha = .7, ax=axes[1][0])
plt.annotate('Very \nSteep', xy=(-1.4, 0.08),
             xycoords="axes fraction", fontsize=12)
plt.annotate('Very \nStrong', xy=(-0.56, 0.07),
             xycoords="axes fraction", fontsize=12)
plt.annotate('C', xy=(-1.55, 1.02),
             xycoords="axes fraction",
             fontsize=12, bbox=bbox_props)

venn2(subsets={'10': 1, '01': 1, '11': 1},
      set_labels = ('GIS', 'R & Python', 'Geology'),
      set_colors=('pink','purple', 'magenta'),
      alpha = .3, ax=axes[1][1])
plt.annotate('Geology',
             xy=(0.8, 0.08), xycoords="axes fraction", fontsize=12)
plt.annotate('D', xy=(-.05, 1.02),
             xycoords="axes fraction",
             fontsize=12, bbox=bbox_props)

plt.suptitle('Interplay of various factors in \nMariana Trench system: Euler-Venn diagrams',
             x=0.54, y=.98, fontsize=12)

# visualizing and saving
plt.tight_layout()
plt.subplots_adjust(top=0.90, bottom=0.08,
                    left=0.10, right=0.95,
                    hspace=0.25, wspace=0.35
                    )
plt.savefig('plot_Venn.png', dpi=300)
plt.show()
