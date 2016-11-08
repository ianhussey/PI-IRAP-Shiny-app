library(lavaan)
shinyServer(function(input, output) {
    
    Raw <- reactive({
        inFile <- input$file1
        if (is.null(input$file1)) { return() }
        Raw <- read.csv(inFile$datapath, header=TRUE, sep=";", dec=",")
        Raw
        })
        
    
    output$var_id <- renderUI({
      #  if (is.null(input$file1)) { return() }
        selectInput("ID", "Select ID", names(Raw()),names(Raw())[1])
    })
    output$var_pr <- renderUI({
      #  if (is.null(input$file1)) { return() }
        selectInput("Block", "Select Block Pair", names(Raw()),names(Raw())[2])
    })
    output$var_tn <- renderUI({
      #  if (is.null(input$file1)) { return() }
        selectInput("Trial", "Select Trial", names(Raw()),names(Raw())[3])
    })
    output$var_cr <- renderUI({
     #   if (is.null(input$file1)) { return() }
        selectInput("Consistency", "Select Consistency", names(Raw()),names(Raw())[4])
    })
    output$var_co <- renderUI({
      #  if (is.null(input$file1)) { return() }
        selectInput("Correct", "Select Correct", names(Raw()),names(Raw())[5])
    })
    output$var_la<- renderUI({
     #   if (is.null(input$file1)) { return() }
        selectInput("RT", "Select RT", names(Raw()),names(Raw())[6])
    })
    output$var_tt<- renderUI({

        selectInput("TrialType", "Select Trial Type", names(Raw()),names(Raw())[7])
    })
    
    observeEvent(input$action, {     
        
        Data <- reactive({
            if (is.null(input$file1)) { return() }
            Raw <- Raw()
            id <- which(names(Raw)==input$ID)
            pr <- which(names(Raw)==input$Block)
            tn <- which(names(Raw)==input$Trial)
            cr <- which(names(Raw)==input$Consistency)
            co <- which(names(Raw)==input$Correct)
            la <- which(names(Raw)==input$RT)
            tt <- which(names(Raw)==input$TrialType)
            print(id)
            #Raw <- Raw[,c(id,bl,tr,co,rt)]
            Raw <- Raw[,c(id,pr,tn,cr,co,la,tt)]
            names(Raw) <- c("ID","PR","TN","CR","CO","LA","TT")
            info <- list(raw=Raw)
            return(info)
            })
        
        output$caption1 <- renderText({

            if (is.null(input$file1)) { return() }
            Dat  <- Data()$raw 
            N <- length(unique(Dat[,1]))
            paste0("Data contain observations of " ,N ," participants")
            })
        
        Out <- reactive({
            
            #source("http://users.ugent.be/~mldschry/IAT/R/iat.R")
            #source("http://users.ugent.be/~mldschry/IAT/R/PI.R") # depends on the pim-package: install.packages("pim")
            #source("http://users.ugent.be/~mldschry/IAT/R/shr.R")
            #source("http://users.ugent.be/~mldschry/IAT/R/ExploreIAT.R")
            source("http://users.ugent.be/~mldschry/IAT/R/Pim_Posset_Irap_function.R")
            
            inFile <- input$file1
        if (is.null(input$file1)) { return() }
        Dat <- Data()$raw 
        #expl <- explore(data=Dat[,1:5],model=input$Method)
        #out1 <- which(expl$flag3 > 0.10)
        #out10 <- which(Dat[,5] > 10000)
        #if(length(out10) > 0){Dat <- Dat[-out10,]}
        #alg <- which(c("D1","D2","D3","D4","D5","D6","C1","C2","C3","C4","G")==input$Score)
        results <- cbind(unique(Dat[,1]),PI_irap(Dat))
        names(results)[1] <- "ID"
        info2 <- list(results=results)
        
        return(info2)
    })
    # output$caption3 <- renderText( {
    #     if (is.null(input$file1)) { return() }
    #     out1 <- Out()$out1
    #     paste(length(out1))
    # })
    # output$caption2 <- renderTable( {
    #     if (is.null(input$file1)) { return() }
    #     out1 <- Out()$out1
    #     x <- length(out1)
    #     ids <- Out()$results$ID
    #     if(x > 0) {X <- as.data.frame(cbind(out1,ids[out1]))
    #         names(X) <- c("Remove","ID")
    #         print(X)
    #         }
    #     #if(x == 0) {paste0("No participants made too many fast responses")}
    # })
    
    Outrel <- reactive({
        
        #source("http://users.ugent.be/~mldschry/IAT/R/Cronbachs_Alpha_IRAP.R")
        
        # input$file1 will be NULL initially. After the user selects and uploads a 
        # file, it will be a data frame with 'name', 'size', 'type', and 'datapath' 
        # columns. The 'datapath' column will contain the local filenames where the 
        # data can be found.
        
        inFile <- input$file1
        if (is.null(input$file1)) { return() }
        if(input$Reliability=="congeneric"){return()}
        Dat <- Data()$raw
        #out1 <- Out()$out1[]
        if(length(out1) > 0) {Dat <- subset(Dat,Dat[,1] %in% unique(Dat[,1])[-out1])}
        #if(input$Reliability =="split"){type <-2}
        #if(input$Reliability =="bootstrap"){type <-3}
        #if(input$Reliability=="none"){type <-1}
        #alg <- which(c("D1","D2","D3","D4","D5","D6","C1","C2","C3","C4","G")==input$Score)
        
        results2 <- alpha_irap(Dat)
        
        info2 <- list(results2=results2)
        
        return(info2)
    })
    
    output$summary <- renderPrint({
        source("http://users.ugent.be/~mldschry/IAT/R/Cronbachs_Alpha_IRAP.R")
        if (is.null(input$file1)) { return() }
        if(input$Reliability!="congeneric"){
            Dat <- Data()$raw
            fit <-  alpha_irap(Dat)
            names(fit) <- c("TT1","TT2","TT3","TT4")
            row.names(fit) <- "alpha"
            #fit <- (2*corr) / (1+corr)
        }
        if(input$Reliability=="congeneric"){
            Dat <- Data()$raw
            out1 <- Out()$out1[]
            if(length(out1) > 0) {Dat <- subset(Dat,Dat[,1] %in% unique(Dat[,1])[-out1])}
            out10 <- Out()$out10[]
            if(length(out10) > 0) {Dat <- Dat[-out10,]}
            alg <- which(c("D1","D2","D3","D4","D5","D6","C1","C2","C3","C4","G")==input$Score)
            
            np <- unique(Dat[,6])
            Plist <- list()
            for(i in np){
                name <- paste0("X",i)
                Plist[[name]] <- iat(data=subset(Dat,Dat[,6]==i), score=alg)$d
                }
            X <- as.data.frame(Plist)
            groupvars <- paste(paste0("lam",np),paste0("X",np),sep="*")
            err <- paste(paste0("X",np,"~~"),paste0("e",np),paste0("*X",np),sep="",collapse=" ; ")
            rel <- paste("rho:=(",paste(paste0("lam",np), collapse=" + "),")^2 / ((",
                         paste(paste0("lam",np), collapse=" + "),")^2 + (",paste(paste0("e",np), collapse=" + "),"))")
            Model<- paste(paste("L=~", paste(groupvars, collapse=" + ")),";",err,";",rel)
            
            fit<- cfa(Model, data=X, std.lv=TRUE) 
            
            }
        #summary(fit, fit.measures=TRUE, standardized=TRUE)    
        round(fit,3)
    })
    
    output$table.raw <- renderTable({
        if (is.null(input$file1)) { return() }
        Dat  <- Data()$raw 
        print(Dat[1:20,])
     })
    output$table.expl <- renderTable({
        if (is.null(input$file1)) { return() }
        Final <- Out()$results
        print(Final)
    })    
     
     
     output$downloadData <- downloadHandler(
         filename = function() { 
             paste("PI", '.csv', sep='') 
         },
         content = function(file) {
             Final <- Out()$results
             write.table(Final, file, sep = ";", dec=",",
                         row.names = FALSE)
         }
     )
 
})
})