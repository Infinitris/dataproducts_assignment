library(shiny)

wt <- function(weight, meas) weight * as.numeric(meas)
ht <- function(height, meas) height * as.numeric(meas)
bmi <- function(weight, height) weight/height^2
ideal_low <- function(height) 18.5*(height^2)
ideal_up <- function(height) 22.9*(height^2)

shinyServer(
  function(input, output) {
    
    weight <- reactive({paste("Weight:", wt(input$weight, input$meas_wt), "kg")})
    height <- reactive({paste("Height:", ht(input$height, input$meas_ht), "m")})
    
    wt_ <- reactive({wt(input$weight, input$meas_wt)})
    ht_ <- reactive({ht(input$height, input$meas_ht)})
    
    output$input_wt = renderText(weight())
    output$input_ht = renderText(height())
    
    output$prediction = renderText({paste(round(bmi(wt_(),ht_()), digits = 1),"kg/m^2")})
    
    output$prediction1 = 
      renderText({
        if(bmi(wt_(),ht_()) >= 27.5) {
          paste("Your BMI is high risk, consider changing your lifestyle to reduce weight as soon as possible. Ideal BMI is between 18.5-22.9.", 
                "Your ideal weight should be between",
                round(ideal_low(ht_()), digits = 1),
                "kg and",
                round(ideal_up(ht_()), digits = 1),
                "kg"
          )
        }
        else if(bmi(wt_(),ht_()) >= 23) {
          paste("Your BMI is moderate risk, consider changing your lifestyle to reduce weight. Ideal BMI is between 18.5-22.9.", 
                "Your ideal weight should be between",
                round(ideal_low(ht_()), digits = 1),
                "kg and",
                round(ideal_up(ht_()), digits = 1),
                "kg"
                )
        }
        else if(bmi(wt_(),ht_()) < 18.5) {
          paste("Your BMI is too low, consider having more nutrition rich food. If not, consult a doctor/nutritionist.",
                "Ideal BMI is between 18.5-22.9",
                "Your ideal weight should be between",
                round(ideal_low(ht_()), digits = 1),
                "kg and",
                round(ideal_up(ht_()), digits = 1),
                "kg"
                )
        }
        else 
        {"Your BMI is low risk. Keep up the good work!"}
      
    })
    
  }
)
