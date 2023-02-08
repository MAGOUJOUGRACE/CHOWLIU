---
output: github_document
---

# CHOWLIU
L'agorithme de Chow-liu permet d'obtenir une structure de dépendences entre variables.
Dans ce package, On a implementer les algorithmes suivant : 
- `Simul_data` 
- `mutual_information` 
- `Prim_max_R` 
- `Naive_R` 
- `Prim_Max_cpp` 
- `Naive` 

```{R}
library(CHOWLIU)
library(microbenchmark)
library(igraph)
```
On simule nos données et on calcule l'information mutuel  
```{R}
sim = simul_data(n=10000,d=10)
W10 = mutual_information(cov_mat = sim$Cov_mat)
```
Notre Graphe avec 10 sommets
```{R}
graph_obj = graph.adjacency(W10, mode="undirected", weighted = TRUE)
plot(graph_obj, edge.label=round(1e5*E(graph_obj)$weight, 2))
```
Le temps moyen pour  l'algorithme naive coder en R pour trouver l'arbre couvrant  de poids maximal
 ```{R}
mean(microbenchmark(Naive_R(weight_mat = W10), times = 100)$time)
```
 Le temps moyen pour  l'algorithme naive codé en CPP pour trouver l'arbre couvrant  de poids maximal
```{R}
mean(microbenchmark(Naive(weight_mat = W10), times = 100)$time)
```
Le temps moyen pour  l'algorithme Prim codé  en R pour trouver l'arbre couvrant  de poids maximal
```{R}
mean(microbenchmark(Prim_max_R(weight_mat = W10), times = 100)$time)
```
Le temps moyen pour  l'algorithme Prim codé en C++ pour trouver l'arbre couvrant  de poids maximal
```{R}
mean(microbenchmark(Prim_max_cpp(weight_mat = W10), times = 100)$time)
```

l'arbre couvrant  de poids maximal
```{R}
adjT = Prim_max_cpp(weight_mat = W10)
tree_obj = graph.adjacency(adjT, mode="undirected", weighted = TRUE)
plot(tree_obj, edge.label=round(1e5*E(tree_obj)$weight, 3))
```






