library(shiny)
library(ViSiElse)


# Create a reactive object here that we can share between all the sessions.

Values <- reactiveValues(rawdata=NULL)



shinyServer( function(input, output,session) {
      
      ### OUT DATA 
      output$contents <- renderTable({
        # input$file1 will be NULL initially. After the user selects
        # and uploads a file, it will be a data frame with 'name',
        # 'size', 'type', and 'datapath' columns. The 'datapath'
        # column will contain the local filenames where the data can
        # be found.
        inFile <- input$file1
        
        if (is.null(inFile))
          return(NULL)
        
        X <- read.csv2(inFile$datapath, header = input$header)
        ### Change the value of the dataset
        isolate(Values$rawdata <- X)
        head( Values$rawdata )
 
      })
      
      ## Plot Summary 
      output$visielse <-  renderPlot({
        X <- Values$rawdata
        if (is.null(X))
          return(NULL)
        print( X )
        X <- visielse( X )
        plot(X)
      })
})
