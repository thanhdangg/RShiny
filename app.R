library(shiny)

# Define UI
ui <- fluidPage(
  titlePanel("Reactive Programming Example"),
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId =  "numInput",label = "Enter a number:", value = 5),
      sliderInput(inputId =  "numSlider",label = "Select a number:", min = 1, max = 10, value = 5, animate = FALSE, step = 0.5),
      textInput(inputId = "txtInput",label =  "Enter text:", placeholder = "Enter input here"),
      actionButton(inputId = "actionBtn",label = "Display Message", icon = ),
      checkboxInput(inputId = "checkbox", label = "Checkbox here", value = FALSE),
      checkboxGroupInput(inputId = "groupCheckBox", label = "Select option: ", choices = c("Option 1", "Option 2", "Option 3"), inline = FALSE),
      radioButtons(inputId = "choice", label = "Choice Example", choices = c("Choose 1", "Choose 2", "Choose 3"), inline = FALSE),
      selectInput(inputId = "selectInput", label = "Select input", choices = c("Select 1", "Select 2", "Select 3"), multiple = TRUE)
    ),
    mainPanel(
      textOutput("doubleOutput"),
      plotOutput(outputId = "plot",height = 500,),
      textOutput("messageOutput"),
      textOutput("newMessageOutput"),
      dataTableOutput(outputId = "tableOutput")
    )
  )
)

# Define Server logic
server <- function(input, output, session) {
  
  # Reactive expression to double the numeric input
  output$doubleOutput <- renderText({
    input_val <- input$numInput
    computed_val <- input_val * 2
    paste("Double of", input_val, "is", computed_val)
  })
  
  # Reactive plot output based on the slider value
  output$plot <- renderPlot({
    input_val <- input$numSlider
    plot(x = seq(input_val,1), y = seq(1, input_val), type = "l",
         main = paste("Sequence from 1 to", input_val))
  })
  
  # Observer for button click event
  observeEvent(input$actionBtn, {
    output$messageOutput <- renderText({
      req(input$txtInput)  # Ensures input is not NULL
      paste("You entered:", input$txtInput)
    })
  })
  output$newMessageOutput <- renderText({
    input_checkbox <- input$groupCheckBox
    input_choice <- input$choice
    input_select <- input$selectInput
    paste("You are select option: ",input_checkbox, "and choose in choice: ",input_choice, "select: ", input_select)
  })
}

# Run the application
shinyApp(ui = ui, server = server)
