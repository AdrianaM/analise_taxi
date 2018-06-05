library(rgdal)
library(raster)
library(rgeos)
library(dplyr)
library(leaflet)
library(magrittr)
library(sp)

# retirado de https://data.cityofnewyork.us/City-Government/Borough-Boundaries/tqmj-j8zm/data
# e https://www.kaggle.com/davidgibsonp/nyc-shape-file-ggplot-map
# carrega shape de Nwe York
NY = readOGR(dsn = "C:/Users/Bruno Aquino/Documents/Rmaps/data", layer = "geo_export_8661594b-4f67-485f-8af1-84a4bd06054d")
row.names(NY) <- c("Queens", "Staten Island", "Bronx", "Brooklyn", "Manhattan")

# Cria o Grid de 50 x 50
# retirado de http://hautahi.com/rmaps
e <- extent(bbox(NY))                  # define boundaries of object
r <- raster(e)                           # create raster object 
dim(r) <- c(100, 100)                      # specify number of cells
projection(r) <- CRS(proj4string(NY))  # give it the same projection as port
g <- as(r, 'SpatialPolygonsDataFrame') 

# seleciona se é partida ou chegada da viagem ('pickup' ou 'dropoff')
pic_drop = 'pickup'

# Carrega a base
train <- read.csv("C:/Users/Bruno Aquino/Downloads/train/train.csv")
# Pega uma amostra da base e seleciona as colunas
coords = sample_n(train[c(paste(pic_drop,'_longitude', sep=''), paste(pic_drop,'_latitude', sep=''))], 500000)
# Transforma as latitudes e longitudes em um objeto SpatialPoints
pt = SpatialPoints(coords)
# Cria um dado para ser contado
data = data.frame(seq(length(pt)))
# Transforma o SpatialPoint + o data.frame em um SpatialPointDataFrama
pt = SpatialPointsDataFrame(pt,data)
# Corta o Grid g no formato de NY
ny_grid <- g[NY,]
# Padroniza os dados com o mesmo CRS (não sei exatamente oq é, sei que é preciso)
proj4string(pt) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")
proj4string(ny_grid) = CRS("+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0")

# conta quantos pontos "pt" estão em cada grid "ny_grid"
pt_agg = aggregate(x=pt, by=ny_grid, FUN=length)
# faz outra transformação CRS que eu não sei ainda se é necessária
pt_agg <- spTransform(pt_agg, CRS("+init=epsg:4326"))
# cria uma função de coloração dos quadrados conforme a quantidade de viagens
qpal <- colorBin('OrRd', pt_agg$seq.length.pt.., bins=9)

# plota o grid "pt_agg" com as cores de qpal
# setView serve para localizar a camera no mapa
# addPolygons e addLegend são intuitivos
leaflet(pt_agg)  %>% addTiles() %>% setView(lng = -73.8992, lat=40.7568,zoom=11) %>% 
  addPolygons(stroke = F,opacity = 1,fillOpacity = 0.7, smoothFactor = 0.5,
              color="black",fillColor = ~qpal(seq.length.pt..),weight = 1) %>%
  addLegend(values=~seq.length.pt..,pal=qpal,title=paste(pic_drop,' count', sep=''))

