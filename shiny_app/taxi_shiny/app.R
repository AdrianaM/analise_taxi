library(shinydashboard)

skin <- Sys.getenv("DASHBOARD_SKIN")
skin <- tolower(skin)
if (skin == "")
  skin <- "blue"


sidebar <- dashboardSidebar(
  #sidebarSearchForm(label = "Search...", "searchText", "searchButton"),
  sidebarMenu(
    #menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    #menuItem("Widgets", icon = icon("th"), tabName = "widgets", badgeLabel = "new",badgeColor = "green"),
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
             menuSubItem("Pontos de Chegada", tabName = "heatmap2")
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
    #,menuItem("Source code for app", icon = icon("file-code-o"),href = "https://github.com/rstudio/shinydashboard/blob/gh-pages/_apps/sidebar/app.R")
  )
)

body <- dashboardBody(
  tabItems(
    tabItem("widgets",
            fluidRow(
              box(
                title = "Distribution",
                status = "primary",
                plotOutput("plot1", height = 280),
                height = 300
              ),
              tabBox(
                height = 300,
                tabPanel("View 1",
                         plotOutput("scatter1", height = 230)
                ),
                tabPanel("View 2",
                         plotOutput("scatter2", height = 230)
                )
              )
            ),
            
            # Boxes with solid headers
            fluidRow(
              box(
                title = "Histogram control", width = 4, solidHeader = TRUE, status = "primary",
                sliderInput("count", "Count", min = 1, max = 500, value = 120)
              ),
              box(
                title = "Appearance",
                width = 4, solidHeader = TRUE,
                radioButtons("fill", "Fill", # inline = TRUE,
                             c(None = "none", Blue = "blue", Black = "black", red = "red")
                )
              ),
              box(
                title = "Scatterplot control",
                width = 4, solidHeader = TRUE, status = "warning",
                selectInput("spread", "Spread",
                            choices = c("0%" = 0, "20%" = 20, "40%" = 40, "60%" = 60, "80%" = 80, "100%" = 100),
                            selected = "60"
                )
              )
            ),
            
            # Solid backgrounds
            fluidRow(
              box(
                title = "Title 4",
                width = 4,
                background = "black",
                "A box with a solid black background"
              ),
              box(
                title = "Title 5",
                width = 4,
                background = "light-blue",
                "A box with a solid light-blue background"
              ),
              box(
                title = "Title 6",
                width = 4,
                background = "maroon",
                "A box with a solid maroon background"
              )
              
            )
    ),
    #Tabs de Enriquecimento
    tabItem("enrq1",paste("Distâncias")),
    tabItem("enrq2",paste("Quadrantes no Mapa")),
    tabItem("enrq3",paste("Pontos de Interesse")),
    
    #Tabs de Analise inicial
    tabItem("analise1",paste("Sumarização")),
    tabItem("analise2",paste("Horários das Corridas")),
    tabItem("analise3",paste("Origens em Função Horário")),
    tabItem("analise4",paste("Destinos em Função Horário")),
    tabItem("analise5",paste("Tempo Médio de Viagem")),
    
    #tabs de Minidataset
    tabItem("minidf1",paste("Subdaset: Aeroporto")),
    
    #Tabs de Clusterização
    tabItem("cluster1",paste("K-Means")),
   
    #tabs de Mapas de Calor
    tabItem("heatmap1",paste("Pontos de Saída")),
    tabItem("heatmap2",paste("Pontos de Chegada")),
    
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

messages <- dropdownMenu(type = "messages",
                         messageItem(
                           from = "Sales Dept",
                           message = "Sales are steady this month."
                         ),
                         messageItem(
                           from = "New User",
                           message = "How do I register?",
                           icon = icon("question"),
                           time = "13:45"
                         ),
                         messageItem(
                           from = "Support",
                           message = "The new server is ready.",
                           icon = icon("life-ring"),
                           time = "2014-12-01"
                         )
)

notifications <- dropdownMenu(type = "notifications", badgeStatus = "warning",
                              notificationItem(
                                text = "5 new users today",
                                icon("users")
                              ),
                              notificationItem(
                                text = "12 items delivered",
                                icon("truck"),
                                status = "success"
                              ),
                              notificationItem(
                                text = "Server load at 86%",
                                icon = icon("exclamation-triangle"),
                                status = "warning"
                              )
)

tasks <- dropdownMenu(type = "tasks", badgeStatus = "success",
                      taskItem(value = 90, color = "green",
                               "Documentation"
                      ),
                      taskItem(value = 17, color = "aqua",
                               "Project X"
                      ),
                      taskItem(value = 75, color = "yellow",
                               "Server deployment"
                      ),
                      taskItem(value = 80, color = "red",
                               "Overall project"
                      )
)

header <- dashboardHeader(
  title = "Projeto Taxi - R"
  #messages,
  #notifications,
  #tasks
)

ui <- dashboardPage(header, sidebar, body, skin = skin)

server <- function(input, output) {
  
  set.seed(122)
  histdata <- rnorm(500)
  
  output$plot1 <- renderPlot({
    if (is.null(input$count) || is.null(input$fill))
      return()
    
    data <- histdata[seq(1, input$count)]
    color <- input$fill
    if (color == "none")
      color <- NULL
    hist(data, col = color, main = NULL)
  })
  
  output$scatter1 <- renderPlot({
    spread <- as.numeric(input$spread) / 100
    x <- rnorm(1000)
    y <- x + rnorm(1000) * spread
    plot(x, y, pch = ".", col = "blue")
  })
  
  output$scatter2 <- renderPlot({
    spread <- as.numeric(input$spread) / 100
    x <- rnorm(1000)
    y <- x + rnorm(1000) * spread
    plot(x, y, pch = ".", col = "red")
  })
}

shinyApp(ui, server)