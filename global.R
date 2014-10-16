# ===================================================================================
# If SavedImage.rda does not exist, initialize shared variables and save to that file.
# If SavedImage.red exist, simply loads image to reduce execution time.
# Author: Vinh N. Pham
# NOTE: variables shared between ui.R and server.R is stored in global.R
# ===================================================================================
rImageFile <- "./SavedImage.rda"

# Function to intialize and save variables
setupEnv <- function() {
  rm(list=ls())
  
  library("AppliedPredictiveModeling")
  data(FuelEconomy)
  
  sizeClassLabel  <<-  c("Other", "2 Seaters Cars", "Compact Cars",
                         "Large Cars", "Mid-size Cars", "Mini Compact Cars",
                         "Small Pickup Trucks 2WD", "Small Pickup Trucks 4WD", "Small Station Wagons",
                         "Minivan 2WD", "SUV 2WD", "SUV 4WD",    
                         "Standard Pickup Trucks 2WD", "Standard Pickup Trucks 4WD", "Sub Compact Cars",
                         "Cargo Type Vans", "Passenger Type Vans")
  
  carImages  <<-  dir("www")
  
  driveConfigLabel <<- c("All Wheel Drive", "Four Wheel Drive", "Part time Four Wheel Drive",
                         "Two Wheel Drive Front", "Two Wheel Drive Rear")
  
  carsDB <<- list(length=4)
  carsDB[["All"]] <<- rbind(cars2010, cars2011, cars2012)
  carsDB[["2010"]] <<- cars2010
  carsDB[["2011"]] <<- cars2011
  carsDB[["2012"]] <<- cars2012
  rm(list=c("cars2010", "cars2011", "cars2012"), envir=.GlobalEnv)
  
  lmModel <<- list(length=4)
  lmModel[["All"]]  <<- lm(formula = FE ~ NumCyl + DriveDesc + CarlineClassDesc, data = carsDB[["All"]])
  lmModel[["2010"]] <<- lm(formula = FE ~ NumCyl + DriveDesc + CarlineClassDesc, data = carsDB[["2010"]])
  lmModel[["2011"]] <<- lm(formula = FE ~ NumCyl + DriveDesc + CarlineClassDesc, data = carsDB[["2011"]])
  lmModel[["2012"]] <<- lm(formula = FE ~ NumCyl + DriveDesc + CarlineClassDesc, data = carsDB[["2012"]])
  
  save.image(rImageFile)  
}

# Load image or initialize image if error.
tryCatch(load(rImageFile),
         error = function(e) {setupEnv()},
         warning = function(w) {setupEnv()})

