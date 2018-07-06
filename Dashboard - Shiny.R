## Dashboard - Shiny.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Portfolio Pessoal - R"),
  dashboardSidebar(sidebarMenu(
    menuItem("O Grupo", tabName = "grupo", icon = icon("users")),
    menuItem("Sobre o Dataset", tabName = "dataset", icon = icon("database")),
    menuItem("Enriquecimento do Dataset", icon = icon("asterisk"), 
             menuSubItem("Distancia em Km", tabName = "distancia-km", icon = icon("plane")),
             menuSubItem("Distancia Euclidiana", tabName = "distancia-euclidiana", icon = icon("plane")),
             menuSubItem("Distancia Manhattan", tabName = "distancia-manhattan", icon = icon("plane")),
             menuSubItem("Quadrantes lat-long", tabName = "quadrantes", icon = icon("globe")),
             menuSubItem("Pontos de Interesse", tabName = "pontos-interesse", icon = icon("home"))
             ),
    menuItem("Analise Basica", icon = icon("check"),
             menuSubItem("Principais Horarios", tabName = "principais-horarios", icon = icon("hourglass-half")),
             menuSubItem("Principais Origens", tabName = "principais-origens", icon = icon("map-marker")),
             menuSubItem("Principais Destinos", tabName = "principais-destinos", icon = icon("map-marker")),
             menuSubItem("Tempo Medio da Viagem", tabName = "tempo-medio-viagem", icon = icon("hourglass-end"))
             ),
    menuItem("Subset", icon = icon("cut"),
             menuSubItem("Filtrar Dataset", tabName = "filtrar-dataset", icon = icon("filter")),
             menuSubItem("Analises sobre Filtro", tabName = "analises-filtro", icon = icon("check-circle"))
             ),
    menuItem("Analises Graficas", icon = icon("align-left"),
             menuSubItem("Linha temporal", tabName = "linha-temporal", icon = icon("calendar")),
             menuSubItem("Clusterizacao", tabName = "clusterizacao", icon = icon("object-group")),
             menuSubItem("Mapa de Calor", tabName = "mapa-calor", icon = icon("delicious"))
             ),
    menuItem("Modelagem ML", tabName = "modelagem", icon = icon("cogs"))
  )),
  ## Body content
  dashboardBody(tabItems(
    # TAB CONTENT - Sobre O Grupo
    tabItem(tabName = "grupo",
            h2("Sobre O Grupo")),
    
    # TAB CONTENT - Sobre o Dataset
    tabItem(tabName = "dataset",
            h2("Sobre o Dataset")),
    
    # TAB CONTENT - Distancia em Km
    tabItem(tabName = "distancia-km",
            h2("Distancia em Km")),
    
    # TAB CONTENT - Distancia Euclidiana
    tabItem(tabName = "distancia-euclidiana",
            h2("Distancia Euclidiana")),
  
    # TAB CONTENT - Distancia Manhattan
    tabItem(tabName = "distancia-manhattan",
            h2("Distancia Manhattan")),
    
    # TAB CONTENT - Quadrantes lat-long
    tabItem(tabName = "quadrantes",
            h2("Quadrantes lat-long")),
    
    # TAB CONTENT - Pontos de Interesse
    tabItem(tabName = "pontos-interesse",
            h2("Pontos de Interesse")),
    
    # TAB CONTENT - Principais Horarios
    tabItem(tabName = "principais-horarios",
            h2("Principais Horarios")),
    
    # TAB CONTENT - Principais Origens
    tabItem(tabName = "principais-origens",
            h2("Principais Origens")),
    
    # TAB CONTENT - Principais Destinos
    tabItem(tabName = "principais-destinos",
            h2("Principais Destinos")),
    
    # TAB CONTENT - Tempo Medio da Viagem
    tabItem(tabName = "tempo-medio-viagem",
            h2("Tempo Medio da Viagem")),
    
    # TAB CONTENT - Filtrar Dataset
    tabItem(tabName = "filtrar-dataset",
            h2("Filtrar Dataset")),
    
    # TAB CONTENT - Analises sobre Filtro
    tabItem(tabName = "analises-filtro",
            h2("Analises sobre Filtro")),
    
    # TAB CONTENT - Linha temporal
    tabItem(tabName = "linha-temporal",
            h2("Linha temporal")),
    
    # TAB CONTENT - Clusterizacao
    tabItem(tabName = "clusterizacao",
            h2("Clusterizacao")),
    
    # TAB CONTENT - Mapa de Calor
    tabItem(tabName = "mapa-calor",
            h2("Mapa de Calor")),
    
    # TAB CONTENT - Modelagem ML
    tabItem(tabName = "modelagem",
            h2("Modelagem Machine Learning"))
    ))
)




server <- function(input, output) {
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    data <- histdata[seq_len(input$slider)]
    hist(data)
  })
}

shinyApp(ui, server)