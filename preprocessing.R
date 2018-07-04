library(magrittr) # quando der problema com o "%>%"
library('dplyr') # selecao e filtro de dados
library('geosphere') # localizacao geoespacial

dist_eucl <- function(df){

  df %>% 
    dplyr::select(pickup_longitude, pickup_latitude) -> df$coordenada_partida
  
  df %>% 
    dplyr::select(dropoff_longitude, dropoff_latitude) -> df$coordenada_chegada
  
  # Distancia euclidiana (considerando a curvatura da Terra como uma esfera)
  distCosine(df$coordenada_partida, df$coordenada_chegada) / 1000
}

dist_manh <- function(df){
  # Calculo da distancia de manhattan
  # Passo 1 - Criar coordenadas fixando a mesma longitude para a chegada e a partida
  df %>% 
    dplyr::select(pickup_longitude, pickup_latitude) -> df$coordenada_partida_longitude_fixa
  df %>% 
    dplyr::select(pickup_longitude, dropoff_latitude) -> df$coordenada_chegada_longitude_fixa
  
  # Passo 2 - Criar coordenadas fixando a mesma latitude para a chegada e a partida
  df %>% 
    dplyr::select(pickup_longitude, pickup_latitude) -> df$coordenada_partida_latitude_fixa
  df %>% 
    dplyr::select(dropoff_longitude, pickup_latitude) -> df$coordenada_chegada_latitude_fixa
  
  # Passo 3 - calcular a distancia considerando a longitude fixa
  distCosine(df$coordenada_partida_longitude_fixa, df$coordenada_chegada_longitude_fixa)  -> df$delta_manhattan_longitude_fixa
  
  distCosine(df$coordenada_partida_latitude_fixa, df$coordenada_chegada_latitude_fixa)  -> df$delta_manhattan_latitude_fixa
  
  # Passo 4 - Somar os deltas obtidos 
  (df$delta_manhattan_latitude_fixa + df$delta_manhattan_longitude_fixa) / 1000

}

min_max_scaler <- function(data){
  return ((data - min(data)) / (max(data) - min(data)))
}

create_formula <- function(data){
  feats <- names(data)
  
  # Concatenate strings
  f <- paste(feats,collapse=' + ')
  f <- paste('trip_duration ~',f)
  
  # Convert to formula
  f <- as.formula(f)
  
  f
}


bairros_func <- function(){
  x1 = -74.008619
  y1 = 40.85939
  x2 = -73.91533
  y2 = 40.70466
  n_col = 2
  n_row = 3
  largura = x1 - x2
  altura = y1 - y2
  lar_quad = largura / n_col
  alt_quad = altura / n_row
  bairros = c()
  
  for (row in seq(y1, y2 + alt_quad, by=-alt_quad)){
    for (col in seq(x1, x2 + lar_quad, by=-lar_quad)){
      bairros = c(bairros, c(col, row, col - lar_quad, row - alt_quad))
    }
  }
  matrix(bairros, ncol=4, byrow=T)
}

bairros = bairros_func()
aeroporto1 = c( -73.848374, 40.688240, -73.723494, 40.615962)
aeroporto2 = c(-73.894189, 40.786195, -73.844867, 40.75191)
aeroportos = matrix(c(aeroporto1, aeroporto2), ncol=4, byrow = T)
bairros = rbind(bairros, aeroportos)

define_bairro <- function(x, y){
  result = nrow(bairros) + 1
  for (i in seq(1:nrow(bairros))) {
    x1 = bairros[i,1]
    y1 = bairros[i,2]
    x2 = bairros[i,3]
    y2 = bairros[i,4]
    if (x > x1 && x < x2 && y < y1 && y > y2){
      result = i
      break()
    }
  }
  result
}

define_bairro(-73.9736, 40.7611)
