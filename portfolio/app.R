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
                    
                    #choose a file
                    selectInput("fileName", 
                                label = "Selecione uma Aula para Download",
                                choices = c("-",
                                            "Aula 1: Introducao ao R", 
                                            "Aula 2: Vetores e Matrizes",
                                            "Aula 3: Amostras e Simulacoes"
                                ),
                                selected = "-"),
                    # Button
                    downloadButton("downloadData", "Download")
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
            "Aula 1: Introducao ao R" = includeMarkdown("aula1.RData")
    )
  )
  
  # Downloadable csv of selected dataset ----
  output$downloadData <- downloadHandler(
    filename = function() {
      switch (input$fileName,
              "Aula 1: Introducao ao R" = paste('aula1.Rmd'),
              "Aula 2: Vetores e Matrizes" = paste('aula2.Rmd'),
              "Aula 3: Amostras e Simulacoes" = paste('aula3.Rmd')
      )
    },
    content = function(file) {
      write_file(datasetInput(), file, row.names = FALSE)
    }
  )
  
}

shinyApp(ui, server)