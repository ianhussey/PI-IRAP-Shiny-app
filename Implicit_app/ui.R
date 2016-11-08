

# Define UI for application that draws a histogram
shinyUI(navbarPage("                                    ",
                   tabPanel("IRAP",
                            fluidPage(
                                
                                # Application title
                                
                                titlePanel("IRAP"),
                                fluidRow(
                                    column(6,column(6,
                                                    wellPanel(
                                                        h4("Upload Test Data"),
                                                        fileInput('file1', 'Choose CSV File',
                                                                  accept=c('text/csv', 
                                                                           'text/comma-separated-values,text/plain', 
                                                                           '.csv')),
                                                        uiOutput("var_id"),
                                                        uiOutput("var_pr"),
                                                        uiOutput("var_tn"),
                                                        uiOutput("var_cr"),
                                                        uiOutput("var_co"),
                                                        uiOutput("var_la"),
                                                        uiOutput("var_tt")
                                                        )
                                                    

                                             
                                                    ),
                                           column(6,
                                                 wellPanel(
                                                      radioButtons('Reliability', 'Reliability',
                                                                   c(None='none',
                                                                     #SplitHalf="cronbach",
                                                                     Cronbachs_Alpha='Cronbach'),
                                                                   'none')
                                                  ),
 
                                                  wellPanel(actionButton("action", label = "Calculate scores"),
                                                                  p("Click the button to start calculations")),  
                                                  wellPanel(downloadButton('downloadData', 'Save Implicit Scores'))
                                           )
                                           
                                    ),
                                    column(6,
                                           tabsetPanel(
                                               tabPanel("Data", 
                                                        h4(textOutput("caption1")),
                                                        tableOutput('table.raw')),

                                               tabPanel("Summary", 
                                                        #h3("Participants with more than 10% RTs faster than 300ms:"),
                                                        #tableOutput("caption2"),
                                                        tableOutput('table.expl'))
                                                        ,
                                                        
                                               tabPanel("Reliability", h3("Reliability:"),
                                                        verbatimTextOutput("summary"))
                                           )
                                    )
                                )
                            )
                   ),
                   tabPanel("About",
                            fluidRow(
                                column(3,
                                       wellPanel(
                                       h4("About"),
                                       p("The App is developped by Maarten De Schryver & Ian Hussey using RStudio's shiny."),
                                       p("For more information, contact:"),
                                       p(strong("Maarten.DeSchryver@Ugent.be")),
                                       p(strong("Ian.Hussey@Ugent.be"))
                                       )),
                                       
                                column(9,
                                       includeHTML("about.html")
                                )))
                                       
))


