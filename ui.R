shinyUI(
        fluidPage(
                includeHTML("documentation.html"),
                sidebarPanel(
                        h4(strong("Filter by Node")),
                        uiOutput("nameUI"),
                        uiOutput("typeUI")
                ),
                mainPanel(
                        fluidRow(DT::dataTableOutput("table"))
                )
        )
)