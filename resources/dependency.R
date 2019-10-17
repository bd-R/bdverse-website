library(pkgnet)
library(tidyverse)
library(networkD3)

a <- pkgnet::CreatePackageReport("bdverse")
edge <- a$DependencyReporter$edges
node <- a$DependencyReporter$nodes

factor <- as.factor(node$node)

s <- lapply(edge$SOURCE, function(e){return(node$numRecursiveDeps[which(node$node == e)])})
v <- unlist(s)
edge$WIDTH <- v

edge$SOURCE <- as.numeric(factor(edge$SOURCE, levels = factor))
edge$TARGET <- as.numeric(factor(edge$TARGET, levels = factor))

edge$SOURCE <- edge$SOURCE - 1
edge$TARGET <- edge$TARGET - 1

node$numRecursiveDeps <- node$numRecursiveDeps ^ 1.3

node <- as.data.frame(node)
node$color <- 1
node[grepl( "bd", node$node),"color"] <- 2

node$img <- "star.png"
node[node$node=="bdDwC",]$img <- "bdDwC-favicon.png"
node[node$node=="bdchecks",]$img <- "bdchecks-favicon.png"
node[node$node=="bdchecks.app",]$img <- "bdchecks.app-favicon.png"
node[node$node=="bdclean",]$img <- "bdclean-favicon.png"
node[node$node=="bddwc.app",]$img <- "bddwc.app-favicon.png"
node[node$node=="bdutilities",]$img <- "bdutilities-favicon.png"
node[node$node=="bdutilities.app",]$img <- "bdutilities.app-favicon.png"
node[node$node=="bdverse",]$img <- "bdverse-favicon.png"

forceNetwork(
    edge,
    node,
    Source = "SOURCE",
    Target = "TARGET",
    Value =  "WIDTH",
    linkDistance = JS("function(d){return d.value * 2}"),
    linkWidth = 1,
    NodeID = "node",
    Nodesize = "numRecursiveDeps",
    Group = "color",
    charge = -150,
    opacity = .8,
    zoom = FALSE,
    bounded = T,
    opacityNoHover = .6
) %>% saveNetwork(file = 'dependency.html')

# Change body background to transparent

# Add this below <head>
<style>
  @import url("https://fonts.googleapis.com/css?family=Nunito+Sans");
  .nodetext{
      font-size: 15px !important;
      font-family: 'Nunito Sans', sans-serif !important;
  }
</style>
  

# Change this in D3 Graph
var node = svg.selectAll(".node")
.data(force.nodes())
.enter().append("g")
.attr("class", "node")
.style("fill", function(d) { return "royalblue"; })
.style("opacity", options.opacity)
.on("mouseover", mouseover)
.on("mouseout", mouseout)
.on("click", click)
.call(drag);

node.append("circle")
.attr("r", function(d){if (d.img === "images/star.png") {return nodeSize(d)} else {return 0}})
.style("stroke", "#fff")
.style("opacity", options.opacity)
.style("stroke-width", "1.5px");

node.append("svg:image")
.attr("xlink:href",  function(d) { if (d.img !== "images/star.png")  return d.img;})
.attr("x", function(d) { return -50;})
.attr("y", function(d) { return -55;})
.attr("height", 100)
.attr("width", 100);

