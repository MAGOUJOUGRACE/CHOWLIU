#'
#'Pour caculer l'information mutuelle d'un graphe, on applique la fonction ci-après à la matrice de variance covariance des variables (sommets du graphe)
#'@import stats
#'@param cov_mat matrice de variance covariance
#'@return Les sommets d'un graphe représentent les variables.
#'@export
mutual_information = function(cov_mat){
  d = ncol(cov_mat)
  MI = matrix(rep(0, d*d), ncol=d, nrow = d)
  for (i in 1:d){
    for (j in 1:d){
      if (i!=j){
        MI[i, j] = 0.5*log((cov_mat[i, i]*cov_mat[j, j])/(cov_mat[i, i]*cov_mat[j, j]-cov_mat[i, j]^2))
        #MI[i, j]

      }

    }

  }

  return(MI)
}
