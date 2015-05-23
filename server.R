library(shiny)
library(tm)

# Define server logic required to plot various variables against mpg
shinyServer(function(input, output) {
  term_frequencies <- reactive({
   page <- readLines(input$url)
   page <- gsub("<.*?>", "", page)
   corpus <- Corpus(VectorSource(page))
   corpus <- tm_map(corpus, tolower)
   corpus <- tm_map(corpus, PlainTextDocument)
   corpus = tm_map(corpus, removePunctuation)
   #remove english stopwords + javascript keywords 
   corpus = tm_map(corpus, removeWords, c(stopwords("english"),
     "abstract", "arguments", "boolean", "break", "byte",
     "case", "catch", "char", "class*", "const",
     "continue", "debugger", "default", "delete", "do",
     "double", "else", "enum*", "eval", "export",
     "extends*", "false", "final", "finally", "float",
     "for", "function", "goto", "if", "implements",
     "import*", "in", "instanceof", "int", "interface",
     "let", "long", "native", "new", "null",
     "package", "private", "protected", "public", "return",
     "short", "static", "super*", "switch", "synchronized",
     "this", "throw", "throws", "transient", "true",
     "try", "typeof", "var", "void", "volatile",
     "while", "with", "yield", 
	 "cookie", "cookies", "amp", "browser", "undefined", "cdata")   
   )
   corpus = tm_map(corpus, stemDocument, language="english")
   fm <- DocumentTermMatrix(corpus)
   m <- as.matrix(sort(colSums(as.matrix(fm)), decreasing=TRUE)[1:input$terms]) 
   df <- as.data.frame(m)
   df$V1 = as.character(df$V1)
   colnames(df)[1] = "frequency"
   df
  })
  output$view <- renderTable(
    term_frequencies()
  )

})
