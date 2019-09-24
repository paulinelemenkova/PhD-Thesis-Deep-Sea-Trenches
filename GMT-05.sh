#!/bin/sh
# Purpose: Geological map in Eckert VI equal-area pseudocylindrical projection (here: Pacific Ocean)
# GMT modules: gmtset, gmtdefaults, pscoast, psxy, psbasemap, pslegend, logo, psconvert
# Step-1. Generate file
ps=GMT_geology_World.ps
# Step-2. GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_FRAME_PEN=dimgray \
    MAP_FRAME_WIDTH=0.1c MAP_TITLE_OFFSET=0.3c \
    MAP_TICK_PEN_PRIMARY=thinner,dimgray \
    MAP_GRID_PEN_PRIMARY=thinner,dimgray \
    FONT_TITLE=12p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY=7p,Helvetica,dimgray \
    FONT_LABEL=7p,Palatino-Roman,dimgray
# Step-3. Overwrite defaults of GMT
gmtdefaults -D > .gmtdefaults
# Step-4. Plot coastmap
gmt pscoast -Rg -JKs180/9i -Gpapayawhip -Slightcyan -W0.25p -Dc \
    -B+t"Geological features: World map. Central meridian at 180\232, Pacific Ocean" \
	-Vv -K > $ps
# Step-5. Add geology
gmt psxy -R -J hotspots.gmt -Sc0.2c -Gred -O -K >> $ps
gmt psxy -R -J ridge.gmt -Sf0.5c/0.15c+l+t -Wthin,purple -Gpurple -O -K >> $ps
gmt psxy -R -J transform.gmt -Sf0.5c/0.15c+l+t -Wthin,orange -Gorange -O -K >> $ps
gmt psxy -R -J trench.gmt -Sf1.5c/0.2c+l+t -Wthick,red -Gred -O -K >> $ps
gmt psxy -R -J LIPS.2001.points.gmt -Sc0.1c -Gyellow -O -K >> $ps
gmt psxy -R -J LIPS.2011.gmt -L -Gp7+bred+f-+r300 -Wthinnest,red -O -K >> $ps
gmt psxy -R -J ophiolites.gmt -Sc0.1c -Gmagenta -O -K >> $ps
gmt psxy -R -J volcanoes.gmt -Sc0.1c -Ggreen -O -K >> $ps
# Step-6. Add grid, scale bar
gmt psbasemap -R -J \
    -Bpx30g30 -Bpy10g10 \
    -Lx11.4c/-1.3c+c50+w10000k+l"Eckert VI equal-area pseudocylindrical projection. Scale (km)"+f \
    -UBL/45p/-40p -O -K >> $ps
# Step-7. Add legend
gmt pslegend -R -J -Dx19.0/-2.0+w5.2c+o0.0/0.2c -F+pthin+ithinner+gwhite \
    --FONT_ANNOT_PRIMARY=8p -O -K << EOF >> $ps
S 0.3c c 0.2c red 0.15p 1.0c Hotspots
S 0.3c f+l+t 0.7c red 0.15p 1.0c Trench
S 0.3c f+l+t 0.7c purple 0.15p 1.0c Ridge
S 0.3c f+l+t 0.7c orange 0.15p 1.0c Transform lines
S 0.3c c 0.2c magenta 0.15p 1.0c Ophiolites
S 0.3c r 0.5c p7+bred+f+r300- 0.15p 1.0c Large igneous provinces (LIPs)
S 0.3c c 0.2c yellow 0.15p 1.0c Spots of LIPs
S 0.3c c 0.2c green 0.15p 1.0c Volcanoes
EOF
# Step-8. Add logo
gmt logo -R -J -Dx10.5/-2.7+o0.1i/0.1i+w2c -O >> $ps
# Step-9. Convert to image file using GhostScript (landscape orientation, 720 dpi)
gmt psconvert GMT_geology_World.ps -A0.5c -E720 -Tj -Z
