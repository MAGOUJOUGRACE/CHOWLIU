#'
#'
#'
#'@import stats
#'@param n nombre d'observation
#'@param d nombre de variable
#'@return simulation des données suivant une loi normale et sa matrice de variance covariance
#'@export
simul_data = function (n = 10000, d = 10){
  # simule une matrice définie positive
  sig =  matrix(rnorm(n*d), ncol = d)
  sig = (1/(n))*t(sig)%*%(sig)
  #on utilise la decomposition de Choleski pour obtenir une matrice suivant une loi normale ayant pour matrice de covariance  **sig**
  L = t(chol(sig))
  X = matrix(rnorm(n*d), ncol=d)
  L = t(chol(sig))
  U = t(L%*%t(X))
  simulation = list(data=U, Cov_mat = sig)
  return(simulation)
}
