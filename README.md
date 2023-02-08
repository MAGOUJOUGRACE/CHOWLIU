---
output: github_document
---

# CHOWLIU
L'algorithme de CHOW-LIU  Nous permet d'approximer une distribution sous forme d'arbre

```{R}
library(CHOWLIU)
library(microbenchmark)
library(igraph)
```
On simule  
```{R}
sim = simul_data(n=10000,d=10)
W10 = mutual_information(cov_mat = sim$Cov_mat)
```
Notre Graphe 
```{R}
graph_obj = graph.adjacency(W10, mode="undirected", weighted = TRUE)
plot(graph_obj, edge.label=round(1e5*E(graph_obj)$weight, 2))
```
 
 ```{R}
mean(microbenchmark(Naive_R(weight_mat = W10), times = 100)$time)
```
 
```{R}
mean(microbenchmark(Naive(weight_mat = W10), times = 100)$time)
```

```{R}
mean(microbenchmark(Prim_max_R(weight_mat = W10), times = 100)$time)
```

```{R}
mean(microbenchmark(Prim_max_cpp(weight_mat = W10), times = 100)$time)
```

The maximum spanning Tree of the full graph
```{R}
adjT = Prim_max_cpp(weight_mat = W10)
tree_obj = graph.adjacency(adjT, mode="undirected", weighted = TRUE)
plot(tree_obj, edge.label=round(1e5*E(tree_obj)$weight, 3))
```






