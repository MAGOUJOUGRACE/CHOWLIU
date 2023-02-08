#include <Rcpp.h>
#include <stdio.h>
#include <math.h>
using namespace Rcpp;
using namespace std;

//
//
//Algorithme de Naive permettant de determiner l'arbre couvrant  de poids maximal
//weight_mat  matrice d'adjacence (matrice des poids  qui lit  les différents sommets d'un graphe)
//[[Rcpp::export]]
NumericVector Naive(NumericMatrix& weight_mat ){
//the number of nodes in the graph
  int V = weight_mat.nrow();
  int parent, child;
  float Max;
//the adjacency matrix to keep MaxWghtSpanningTree
  NumericMatrix Mat(V,V);
  for(int i = 0; i < V; i++){
    for(int j = 0; i < V; i++){
      Mat(i,j) = 0;
    }
  }
//A vector to keep track of the included nodes so far
  LogicalVector MST(V);
  for(int i = 0; i < V; i++){
      MST[i]= false;
    }

  MST[1] = true;

  for (int m = 0; m < V; m++){

    Max = -INFINITY;
    parent = NULL;
    child = NULL;
    for(int i = 0; i < V; i++){
      if ( MST[i]){
        for(int j = 0; j < V; j++){
          if (weight_mat(i,j)!=0 && MST[j]==false){
            if (weight_mat(i, j) > Max){
              Max = weight_mat(i, j);
              parent = i;
              child = j;
            }
          }
        }
      }
    }
    Mat(parent, child) = weight_mat(parent, child);
    Mat(child, parent) = Mat(parent, child);
    MST[child]=true;
  }
  return(Mat);

}
