library(magrittr) # quando der problema com o "%>%"
library('dplyr') # selecao e filtro de dados
library('geosphere') # localizacao geoespacial

dist_eucl <- function(df){

  df %>% 
    select(pickup_longitude, pickup_latitude) -> df$coordenada_partida
  
  df %>% 
    select(dropoff_longitude, dropoff_latitude) -> df$coordenada_chegada
  
  # Distancia euclidiana (considerando a curvatura da Terra como uma esfera)
  distCosine(df$coordenada_partida, df$coordenada_chegada) / 1000
}

dist_manh <- function(df){
  # Calculo da distancia de manhattan
  # Passo 1 - Criar coordenadas fixando a mesma longitude para a chegada e a partida
  df %>% 
    select(pickup_longitude, pickup_latitude) -> df$coordenada_partida_longitude_fixa
  df %>% 
    select(pickup_longitude, dropoff_latitude) -> df$coordenada_chegada_longitude_fixa
  
  # Passo 2 - Criar coordenadas fixando a mesma latitude para a chegada e a partida
  df %>% 
    select(pickup_longitude, pickup_latitude) -> df$coordenada_partida_latitude_fixa
  df %>% 
    select(dropoff_longitude, pickup_latitude) -> df$coordenada_chegada_latitude_fixa
  
  # Passo 3 - calcular a distancia considerando a longitude fixa
  distCosine(df$coordenada_partida_longitude_fixa, df$coordenada_chegada_longitude_fixa)  -> df$delta_manhattan_longitude_fixa
  
  distCosine(df$coordenada_partida_latitude_fixa, df$coordenada_chegada_latitude_fixa)  -> df$delta_manhattan_latitude_fixa
  
  # Passo 4 - Somar os deltas obtidos 
  (df$delta_manhattan_latitude_fixa + df$delta_manhattan_longitude_fixa) / 1000

}

min_max_scaler <- function(data){
  return ((data - min(data)) / (max(data) - min(data)))
}



