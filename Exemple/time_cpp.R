#'@import igraph
#'@import microbenchmark



sim = simul_data(n=10000,d=10)
W10 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=50)
W50 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=100)
W100 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=150)
W150 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=200)
W200 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=250)
W250 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=300)
W300 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=500)
W500 = mutual_information(cov_mat = sim$Cov_mat)


sim = simul_data(n=10000,d=1000)
W1000= mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=1200)
W1200 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(d=1400)
W1400 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(d=1600)
W1600 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=1800)
W1800 = mutual_information(cov_mat = sim$Cov_mat)

sim = simul_data(n=10000,d=2000)
W2000 = mutual_information(cov_mat = sim$Cov_mat)



# The full garph of 10 nodes in this case
graph_obj = graph.adjacency(W10, mode="undirected", weighted = TRUE)
plot(graph_obj, edge.label=round(1e5*E(graph_obj)$weight, 2))


adjT = Prim_max_cpp(weight_mat = W10)

# The maximum spanning Tree of the full graph
tree_obj = graph.adjacency(adjT, mode="undirected", weighted = TRUE)
plot(tree_obj, edge.label=round(1e5*E(tree_obj)$weight, 3))


a = microbenchmark(Naive(weight_mat = W10), times = 100)
mean(a$time)


b = microbenchmark(Prim_max_cpp(weight_mat = W10), times = 100)
mean(b$time)



dat = list(w10=W10, w50=W50, w100=W100, w150=W150, w200=W200,
           w250=W250, w300=W300, w500=W500, w1000=W1000, w1200=W1200, w1400=W1400, w1600=W1600, w1800=W1800, w2000=W2000)
vs = c(10, 50, 100, 150, 200, 250, 300, 500, 1000, 1200, 1400, 1600, 1800, 2000)
tnaive = c()
k = 0
for (elem in dat){

  a = microbenchmark(Naive(weight_mat = elem), times = 5)
  tnaive=c(tnaive, mean(a$time))
  k = k + 1
  print(k)
}

summary(lm(log(tnaive)~log(vs)))

plot(log(vs), log(tnaive))

topt = c()
k = 0
for (elem in dat){

  b = microbenchmark(Prim_max_cpp(weight_mat = elem), times = 5)
  topt = c(topt, mean(b$time))
  k = k + 1
  print(k)
}


summary(lm(log(topt)~log(vs)))



