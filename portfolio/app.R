library(shiny)
library(readr)
library(dplyr)
library(shinythemes)
packageVersion('plotly')

ui <- fluidPage(theme = shinytheme("darkly"),
                
                #titulo do painel
                titlePanel("Portfólio - Programando IA com R"),
                
                #sidebar
                sidebarLayout(
                  
                  #conteudo da sidebar
                  sidebarPanel(
                    selectInput("fileName", 
                                label = "Selecione uma Aula para Download",
                                choices = c("-",
                                            "Aula 1: Introducao ao R", 
                                            "Aula 2: Vetores e Matrizes",
                                            "Aula 3: Amostras e Simulacoes"
                                ),
                                selected = "-")
                    #downloadButton('downloadData', label = "Donwload")
                  ),  
                  
                  
                  
                  #display do mainpainel
                  mainPanel(
                    tabsetPanel(
                      tabPanel("R Markdown", tableOutput('rmark')),
                      tabPanel("RData", tableOutput('rdata'))
                    )
                  )
                )
)

server <- function(input, output, session) {
  
  output$downloadData <- downloadHandler(
    
    filename = function() {
      paste(aula1.Rmd)
    }
  )
  
  output$rmark <- renderUI({
    switch (input$fileName,
      "Aula 1: Introducao ao R" = includeMarkdown('aula1.Rmd'),
      "Aula 2: Vetores e Matrizes" = includeMarkdown('aula2.Rmd'),
      "Aula 3: Amostras e Simulacoes" = includeMarkdown('aula3.Rmd')
      )}

  )
  
  output$rdata <- renderTable(
    switch (input$fileName,
            "Aula 1: Introducao ao R" = save(df,file = 'aula1_rdata.RData')
    )
  )
}

shinyApp(ui, server)