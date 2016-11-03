library(shiny)

# Define UI for dataset viewer application
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("BMI Calculator"),
  
    sidebarPanel(
      h4("Instructions:"),
      h5("Welcome to this simple BMI calculator. Enter your measurements in the boxes below and be sure to indicate whether they are metric or imperial by selecting the correct buttons."),
      numericInput('weight', 'Weight in kg/lbs', 50, min = 10, max = 500, step = 1),
      radioButtons('meas_wt', label = 'Measurement System for weight',
                   choices = list(Metric=1,
                     Imperial=0.45),
                   selected = 1),
      numericInput('height', 'Height in cm/inches', 160, min = 10, max = 250, step = 1),
      radioButtons('meas_ht', label = 'Measurement System for height',
                   choices = list(Metric=0.01,
                     Imperial=0.025),
                   selected = 0.01)
    ),
    mainPanel(
        h4('Your measurements are:'),
        textOutput("input_wt"),
        textOutput("input_ht"),
        h4('Your BMI is:'),
        textOutput("prediction"),
        h4('More Information:'),
        textOutput("prediction1"),
        
        h4('Reference:'),
        h5('BMI stands for Body Mass Index. It is derived from weight in kilograms divided by the squared of height in metres'),
        h5('The comments above are based on the Asian BMI standards, which is lower than the conventional one since they are at a higher risk of heart diseases.')
        
    )
  )
)

