#include <Rcpp.h>
#include <stdio.h>
#include <math.h>
using namespace Rcpp;
using namespace std;

//
//
// Algorithme de Prim permettant de determiner l'arbre couvrant  de poids maximal
//  weight_mat :  matrice d'adjacence (matrice des poids  qui lit  les différents sommets d'un graphe)
//[[Rcpp::export]]
NumericVector Prim_max_cpp(NumericMatrix& weight_mat){
  int V = weight_mat.ncol();
  NumericVector parent(V);
  NumericVector weight(V);
  LogicalVector MST(V);
  int index;
  float Max;

  NumericMatrix Mat(V,V);
  for(int i = 0; i < V; i++){
    for(int j = 0; i < V; i++){
      Mat(i,j) = 0;
    }
  }

  for(int i = 0; i < V; i++){
    weight[i]= -INFINITY;
  }
  for(int i = 0; i < V; i++){
    MST[i]= false;
  }
  for(int i = 0; i < V; i++){
    parent[i]= NULL;
  }



  weight[0]=0;
  parent[0]=-1;

  for (int l = 0; l < V; l++){

    Max = -INFINITY;
    for (int i = 0; i<V; i++ ){
      if (weight[i] > Max && MST[i] == false){
        Max = weight[i];
        index = i;
      }
    }
    MST[index] = true;


    for (int v = 0; v < V; v++){
      if (weight_mat(index, v) && !MST[v] && weight[v] < weight_mat(index, v)){
        weight[v] = weight_mat(index, v);
        parent[v] = index + 1;
      }
    }
  }
  for (int i = 1; i < V; i++){
    Mat(i, parent[i]-1) = weight_mat(i, parent[i]-1);
    Mat(parent[i]-1, i) = Mat(i, parent[i]-1);
  }


  return (Mat);
}


