#'
#'
#'Algorithme de Naive
#'
#'@param weight_mat  matrice d'adjacence (matrice des poids  qui lit  les différents sommets d'un graphe)
#'@return   l'arbre couvrant  de poids maximal
#'@export
Naive_R = function(weight_mat){

  #Nombre de sommets dans le graphe
  V = nrow(weight_mat)
  #Matrice d'adjacence gardant les poids maximal MaxWghtSpanningTree
  Mat = matrix(rep(0, V^2), nrow=V)
  #Vecteur qui definit si un sommet a été  ajouté à l'arbre ou non
  MST = rep(FALSE, V)

  MST[1] = TRUE

  for (m in 1:V){
    # Initialisation
    Max = -Inf
    parent = NULL
    child = NULL
    # Recherche des index ayants les poids maximaux
    for (i in 1:V){
      if (MST[i]){
        for (j in 1:V){
          if (weight_mat[i, j]&MST[j]==F){
            if (weight_mat[i, j] > Max){
              Max = weight_mat[i, j]
              parent = i
              child = j
            }
          }
        }
      }
    }
    # Remplissage de la matrice d'adjacence
    Mat[parent, child] = weight_mat[parent, child]
    Mat[child, parent] = Mat[parent, child]
    MST[child]=T
  }
  return(Mat)
}
