library(shiny)

# Define UI for miles per gallon application
shinyUI(pageWithSidebar(

  # Application title
  headerPanel("Find the n most common words in a web page"),

  sidebarPanel(
    textInput("url", "URL:", "http://www.cnn.com"),
	textInput("terms", "number of terms:", "10"),
	submitButton("Go!"),
	h3("Instructions"),
	p('Type in the url and the number of words and push Go!'),
	p('English stopwords and JavaScript keywords are removed')
  ),

  mainPanel(
    tableOutput("view")
  )
))
