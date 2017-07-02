library(shiny)

# Define UI for application that draws a histogram

shinyUI(
  fluidPage(
    mainPanel(
      tabsetPanel(
#        tabPanel("Summary", dataTableOutput("dis")),
        tabPanel("common",
                 fluidRow(
                   column(width = 6, plotOutput("plot1")),
                   column(width = 6, plotOutput("plot2"))
                   )
                 ),
        tabPanel("case 1",
                 fluidRow(
                   column(width = 6, plotOutput("plot3")),
                   column(width = 6, plotOutput("plot4"))
                 )
        ),
        tabPanel("case 2",
                 fluidRow(
                   column(width = 6, plotOutput("plot5")),
                   column(width = 6, plotOutput("plot6"))
                 )
        ),
        tabPanel("case 3",
                 fluidRow(
                   column(width = 6, plotOutput("plot7")),
                   column(width = 6, plotOutput("plot8"))
                 )
        )
        )
      )
    )
  )