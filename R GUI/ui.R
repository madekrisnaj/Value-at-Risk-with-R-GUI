library(shinythemes)
ui <- fluidPage(theme=shinytheme("superhero"),
                titlePanel("Value at Risk Saham dengan Simulasi Monte Carlo"),
                h4("By : I Made Krisna Jaya"),
                navbarPage("VaR Monte Carlo",
                           
                           tabPanel("Data",
                                    sidebarLayout(
                                      sidebarPanel(
                                        fileInput("data","masukkan data stock closing price ",accept = c("text",".txt"))
                                      ),
                                      mainPanel(
                                        tabsetPanel(type = "pills",id = "navbar",
                                                    tabPanel("Grafik",
                                                             plotOutput("tsplot"),
                                                             value="Plot"),
                                                    tabPanel("Data",verbatimTextOutput("deskriptif"),verbatimTextOutput("data"),verbatimTextOutput("ret"),value="Data"),
                                                    tabPanel("Uji Normalitas Return",verbatimTextOutput("normalitas"),value="Uji Normalitas Return")
                                        )	)	)
                           ),
                           tabPanel("Simulasi Monte Carlo",
                                    sidebarLayout(
                                      sidebarPanel(
                                        textInput("w","Investasi Awal"),
                                        textInput("N","Banyak Simulasi"),
                                        actionButton("hitung1","Jalankan Program",class="btn-primary")
                                      ),
                                      mainPanel(
                                        tabsetPanel(type = "pills",id = "navbar",
                                                    tabPanel("Hasil Pengolahan Simulasi Monte Carlo",verbatimTextOutput("VAR"),verbatimTextOutput("interpretasi"),value="Hasil")
                                        ))))
                ))
