#Bibliotecas de uso
library(magrittr) # quando der problema com o "%>%"
library(dplyr) # selecao e filtro de dados
library(geosphere) # localizacao geoespacial
library(lubridate) # datas, fun??es hour, month, wday
library(plotly) # plot dos gr?ficos
library(knitr) # usada pelo plotly
library(dummies) # cria colunas bin?rias para vari?veis categ?ricas
library(scales) # normaliza dados rescalando para float de 0 a 1
library(randomForest) # cria rede neural para criar regress?o de tempo de viagem
#source('./analise_taxi/preprocessing.R')
#source('mapa_calor_ny.R')
library(shinydashboard)

#Skin do Shiny dashboard
skin <- Sys.getenv("DASHBOARD_SKIN")
skin <- tolower(skin)
if (skin == "")
  skin <- "blue"

sidebar <- dashboardSidebar(
  
  sidebarMenu(
    
    menuItem("Análise Inicial", icon = icon("database"),
             menuSubItem("Sumarização", tabName = "analise1"),
             menuSubItem("Horários das Corridas", tabName = "analise2"),
             menuSubItem("Origens em Função Horário", tabName = "analise3"),
             menuSubItem("Destinos em Função Horário", tabName = "analise4"),
             menuSubItem("Tempo Médio de Viagem", tabName = "analise5")
    ),
    menuItem("Enriquecimento", icon = icon("dollar"),
             menuSubItem("Distâncias", tabName = "enrq1"),
             menuSubItem("Quadrantes no Mapa", tabName = "enrq2"),
             menuSubItem("Pontos de Interesse", tabName = "enrq3")
    ),
    menuItem("Minidataset", icon = icon("table"),
             menuSubItem("Subdaset: Aeroporto", tabName = "minidf1")
    ),
    menuItem("Clusterização", icon = icon("object-group"),
             menuSubItem("K-Means", tabName = "cluster1")
    ),
    menuItem("Mapa de Calor", icon = icon("map"),
             menuSubItem("Pontos de Saída", tabName = "heatmap1"),
             menuSubItem("Pontos de Chegada", tabName = "heatmap2"),
             menuSubItem("Mapa de Calor NY", tabName = "heatmap3")
    ),
    menuItem("Análises Gráficas", icon = icon("signal"),
             menuSubItem("Linha Temporal Mês", tabName = "analise_grafica1"),
             menuSubItem("Linha Temporal Semana", tabName = "analise_grafica2"),
             menuSubItem("Linha Temporal Hora do Dia", tabName = "analise_grafica3")
    ),
    menuItem("Modelo Machine Learning", icon = icon("graduation-cap"),
             menuSubItem("Váriaveis de Entrada e Saída", tabName = "modelagem1"),
             menuSubItem("Modelo ML", tabName = "modelagem2")
            
    ),
    menuItem("Sobre os Alunos", tabName='alunos', icon = icon("users")
    )
  )
)

body <- dashboardBody(
  tabItems(
    
    #Tabs de Analise inicial
    #Sumarização do DataSet
    tabItem("analise1",fluidRow(
      title="Sumarização do Dataset",
      sidebarLayout(
        sidebarPanel(textOutput('rows_out')),
        mainPanel(dataTableOutput('table1')),
        position = 'right'
      ))),

    #Horario das Corridas
    tabItem("analise2",includeHTML('analise1.HTML')),
    
    
    tabItem("analise3",paste("Origens em Função Horário")),
    tabItem("analise4",paste("Destinos em Função Horário")),
    tabItem("analise5",paste("Tempo Médio de Viagem")),
    
    #Tabs de Enriquecimento
    tabItem("enrq1",paste("Distâncias")),
    tabItem("enrq2",paste("Quadrantes no Mapa")),
    tabItem("enrq3",paste("Pontos de Interesse")),
    
    #tabs de Minidataset
    tabItem("minidf1",paste("Subdaset: Aeroporto")),
    
    #Tabs de Clusterização
    tabItem("cluster1",paste("K-Means")),
   
    #tabs de Mapas de Calor
    tabItem("heatmap1",paste("Pontos de Saída")),
    tabItem("heatmap2",paste("Pontos de Chegada")),
    tabItem("heatmap3",paste("Heatmap Ny")),
    
    #tab de analises Gráficas
    tabItem("analise_grafica1",paste("Line Plot Mês")),
    tabItem("analise_grafica2",paste("Line Plot Semana")),
    tabItem("analise_grafica3",paste("Line Plot Hora do Dia")),
  
    #tab de Modelagem Machine Learning
    tabItem("modelagem1", paste("Váriaveis de Entrada e Saída")),
    tabItem("modelagem2", paste("Modelo ML")),
    
    #tab sobre os alunos
    tabItem("alunos", paste("Integrantes do Grupo"))
  )
)

header <- dashboardHeader(
  title = "Projeto Taxi - R"
)

ui <- dashboardPage(header, sidebar, body, skin = skin)

server <- function(input, output) {
  
  #Load do RData com o full dataset
  load('C:/Users/Vinicius Simioni/Documents/FIAP/Projeto Taxi NY/train_test.RData')
 
  output$table1 <- renderPlot({
    summary(train)
  })
  
  output$plot1 <- renderPlot({
    train %>%
      mutate(hpick = hour(pickup_datetime)) %>%
      group_by(hpick, vendor_id) %>%
      count() %>%
      ggplot(aes(hpick, n, color = vendor_id)) +
      geom_point(size = 4) +
      labs(x = "Hour of the day", y = "Total number of pickups") +
      theme(legend.position = "none")
  })
  
}

shinyApp(ui, server)