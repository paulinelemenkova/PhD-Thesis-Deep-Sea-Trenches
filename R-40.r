# Important notes on methodology. Here: I build a flowchart-diagram of hierarchical structure of the 'Mariana Trench' project work, i.e. methods used in the research  (12, hierarchy of 1 level), methods used (total 100, hierarchy of 2 level). For instance, class 'GIS analysis' has sub-types 'GIS projections', 'visualization', 'cartography', 'spatial  analysis' etc. Correlation class has sub-types 'k-means clustering', 'correlograms', 'dendrograms' etc. Here: create connections between the items (connections go by ID, here: 12 main joints of 1 hierarchical level - centroids (1:12): connections between the hierarchies of level 1, from 13 up to 111: nodes of the hierarchy of 2 level. Connections from levels 1 to 2. All nodes by both levels are stored in a table together (nodes.csv). A table has 2 columns: ID and names. Table connections.csv stores connections, e.g. level 1 towards sublevels 13,14,15,16 etc. Level 2: towards its sub-levels etc. There are 2 tables: 'nodes.csv' and 'connections.csv' . Column 'weight' of connections.csv keeps importance of connections.
# step-1. Preparing data and network
library(igraph)
nodes <- read.table("nodes.csv", header = T, sep = ",", stringsAsFactors = FALSE)
connections <- read.table("connections.csv", header = T, sep = ",", stringsAsFactors = FALSE)
net <- graph_from_data_frame(connections, directed = F, vertices = nodes)
#V(net)$color <- "orange"
#V(net)$label <- "name"
V(net)$size <- 10
E(net)$arrow.mode <- 0
vertex.label= nodes$name
# step-2. Plotting
library(RColorBrewer)
coul = brewer.pal(8, "Set1")
plot(net, vertex.label= nodes$name, vertex.color = coul, vertex.size=4, vertex.label.font = 1, vertex.label.cex = .6, vertex.label.dist = 3.0, vertex.frame.color = 'blue')

