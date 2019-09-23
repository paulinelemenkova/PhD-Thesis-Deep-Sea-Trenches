# Part-1
# step-1. Create hierarchical structure of the data frame (groups and leaves)
d1=data.frame(from="origin", to=paste("profile", seq(1:25), sep="_"))
d2=data.frame(from=rep(d1$to, each=4), to=paste(c("Slope angle", "Bathymetry", "Sediment thickness", "Tectonic plates"), seq(1,100)))
edges=rbind(d1, d2)
# step-2. Create connections between the individual leaves
all_leaves=paste(c("Slope angle", "Bathymetry", "Sediment thickness", "Tectonic plates"), seq(1,100))
connect=rbind( data.frame( from=sample(all_leaves, 100, replace=T) , to=sample(all_leaves, 100, replace=T)), data.frame( from=sample(head(all_leaves), 30, replace=T) , to=sample( tail(all_leaves), 30, replace=T)), data.frame( from=sample(all_leaves[25:30], 30, replace=T) , to=sample( all_leaves[55:60], 30, replace=T)), data.frame( from=sample(all_leaves[175:180], 30, replace=T) , to=sample( all_leaves[155:160], 30, replace=T)) )
connect$value=runif(nrow(connect))
#  step-3. Create vertices in a data.frame: one line per object of the hierarchy
vertices = data.frame(name = unique(c(as.character(edges$from), as.character(edges$to))) , value = runif(126))
#  step-4. Add column with groups names, to color points by groups
vertices$group = edges$from[ match( vertices$name, edges$to ) ]

# Part-2. Add information on labels: slope angles
# step-5.
vertices$id=NA
myleaves=which(is.na( match(vertices$name, edges$from) ))
nleaves=length(myleaves)
vertices$id[ myleaves ] = seq(1:nleaves)
vertices$angle= 90 - 360 * vertices$id / nleaves
#  step-6. calculate the alignment of labels: right or left
vertices$hjust<-ifelse( vertices$angle < -90, 1, 0)
#  step-7. flip angle BY to make them readable
vertices$angle<-ifelse(vertices$angle < -90, vertices$angle+180, vertices$angle)

# Part-3 Create graphic object
#  step-8. The connection object must refer to the ids of the leaves:
mygraph <- graph_from_data_frame( edges, vertices=vertices )
from = match( connect$from, vertices$name)
to = match( connect$to, vertices$name)

# Part-4 Plotting
#  step-9.
M<- ggraph(mygraph, layout = 'dendrogram', circular = TRUE) +
geom_node_point(aes(filter = leaf, x = x*1.07, y=y*1.07, colour=group, size=value), alpha=0.2) +
geom_node_text(aes(x = x*1.15, y=y*1.15, filter = leaf, label=name, angle = angle, hjust=hjust, colour=group), size=2, alpha=1) +
geom_conn_bundle(data = get_con(from = from, to = to), alpha=0.2, width=0.5, aes(colour=..index..)) +
scale_edge_colour_distiller(palette = "BuPu") +
scale_colour_manual(values= rep( brewer.pal(9,"Paired") , 30)) +
scale_size_continuous( range = c(0.1,10) ) +
theme_void() +
expand_limits(x = c(-1.4, 1.4), y = c(-1.4, 1.4)) +
labs(
title = "Mariana Trench",
subtitle = "Structured Edge Bundling: \nConnections Between Leaves of a Hierarchical Network") +
theme(
legend.position="right",
legend.text = element_text(family = "Times New Roman", colour="black", size=6, face=1),
legend.title = element_text(family = "Times New Roman", colour="black", size=8, face=1),
plot.title = element_text(family = "Times New Roman", face = 2, size = 12),
plot.subtitle = element_text(family = "Times New Roman", face = 1, size = 10),
plot.margin=unit(c(0.5,0.5,0.5,0.5),"cm"))
M
