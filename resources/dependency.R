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
    Group = "numRecursiveRevDeps",
    charge = -100,
    opacity = .8,
    zoom = FALSE,
    bounded = T,
    opacityNoHover = .6
) %>%
    saveNetwork(file = 'dependency.html')

# Change background to transparent

#' # Add this below <head>
<style>
  @import url("https://fonts.googleapis.com/css?family=Nunito+Sans");
  .nodetext{
      font-size: 15px !important;
      font-family: 'Nunito Sans', sans-serif !important;
  }
</style>

