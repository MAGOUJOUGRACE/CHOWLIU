#'Algorithme de Prim
#'
#'@param weight_mat  matrice d'adjacence (matrice des poids  qui lit  les différents sommets d'un graphe)
#'@return l'arbre couvrant  de poids maximal
#'@export
Prim_max_R = function(weight_mat){
  # Initialisation
  V = ncol(weight_mat)
  parent = rep(NULL, V)
  weight = rep(-Inf, V)
  MST = rep(FALSE, V)
  Mat = matrix(rep(0, V^2), nrow=V)

  #Attribution de valeurs
  weight[1]=0
  parent[1]=-1

  #Recherche du sommet v ayant le poids maximal
  for (l in 1:V){

    #Parcours des sommets à la recherche du poids maximal et de son index
    Max = -Inf
    for (i in 1:V){
      if (weight[i] > Max & MST[i] == FALSE){
        Max = weight[i]
        index = i
      }
    }
    MST[index] = TRUE


    # Mise à jour des poids
    for (v in 1:V){
      if (weight_mat[index, v] & !MST[v] & weight[v] < weight_mat[index, v]){
        weight[v] = weight_mat[index, v]
        parent[v] = index
      }
    }
  }

  for (i in 2:V){
    Mat[i, parent[i]] = weight_mat[i, parent[i]]
    Mat[parent[i], i] = Mat[i, parent[i]]
  }
  return (Mat)
}
