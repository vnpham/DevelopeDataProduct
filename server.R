# ===================================================================================
# Server part of the application
# Author: Vinh N. Pham
# NOTE: variables shared between ui.R and server.R is stored in global.R
# ===================================================================================
library(shiny)
library(jpeg)

# Function to calculate the prediction
prediction <- function(modelYear, sizeClass, driveConfig, numberOfCylinder) {
  currentModel <- lmModel[[modelYear]]
  carDBModel <- carsDB[[modelYear]]
  currentDriveConfig <- levels(carDBModel$DriveDesc)[[match(driveConfig, driveConfigLabel)]]
  currentSizeClass <- levels(carDBModel$CarlineClassDesc)[[match(sizeClass, sizeClassLabel)]]

  inDatabase <- nrow(subset(carDBModel,
                            DriveDesc == currentDriveConfig &
                            CarlineClassDesc == currentSizeClass))


  mpgMessage <- if (inDatabase > 0) {
    result <- predict(currentModel,
                      data.frame(NumCyl=as.numeric(numberOfCylinder),
                                 DriveDesc=currentDriveConfig,
                                 CarlineClassDesc=currentSizeClass),
                      interval="confidence")
    paste("mpg =", round(result[[1]], 2), "miles/gallon,",
          "confident interval = [", round(result[[2]],2), ",", round(result[[3]],2), "].")
  }
  else {
    "This model configuration does not exist in the database"
  }
}

# Main part of the server function
shinyServer(function(input, output) {
  output$valueSelectedMessage  <- renderText({paste(
                                          "model year =", input$modelYear, ", ",
                                          "size class =", input$sizeClass, ", ",
                                          "drive configuration =", input$driveConfig, ", ",
                                          "number of cylinder =", input$numberOfCylinder, ".")})
  
  imageSrc <- reactive({carImages[sizeClassLabel==input$sizeClass]})
  output$carImageSrc <- imageSrc
  
  output$carImage <- renderImage({
      list(src=paste("www", imageSrc(), sep="/"),
        alt="Representative Image")
    }, deleteFile=FALSE)

  output$mpgMessage <- renderText({prediction(input$modelYear, input$sizeClass, input$driveConfig, input$numberOfCylinder)})
})
