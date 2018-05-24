library(shiny)
library(plotly)
library(readr)
library(dplyr)
packageVersion('plotly')

ui <- fluidPage(
  
  titlePanel("Projeto New York Taxi"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("var", 
                  label = "Selecione um plot",
                  choices = c("-","Quantidade de viagens por hora", 
                              "Media Duracao Viagens",
                              "Duracao da Corrida"
                  ),
                  selected = "-")
    ),
    
    mainPanel(
      textOutput("selected_var"),
      plotlyOutput("plot")
      
    )
  )
  
)

server <- function(input, output, session) {
  
  output$selected_var <- renderText({ 
    paste("Grafico de: ", input$var)
  })
  output$plot <- renderPlotly({
    par(mar = c(4, 4, .1, .1))
    switch (input$var,
            "-"=plot_ly(),
            
            "Media Duracao Viagens" = 
              plot_ly(data = data_triptempo, x= ~pickup_hour, y= ~mean_trip_duration, type = 'bar') %>% 
              layout(xaxis=x_plt1,yaxis=y_plt1),
            
            'Quantidade de viagens por hora' = 
              plot_ly(data= data_tripperhour, x= ~pickup_hour, y= ~n, type = 'bar') %>% 
              layout(xaxis=x_plt2,yaxis=y_plt2),
            
            "Duracao da Corrida" =
              plot_ly(data= data_tripduration, x= ~trip_duration, y= ~n, type = 'bar') %>% 
              layout(xaxis=x_plt3,yaxis=y_plt3)
    )
  })
}

shinyApp(ui, server)