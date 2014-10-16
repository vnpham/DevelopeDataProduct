---
title: "Fuel Efficiency for Car Dummies"
author: Vinh N. Pham
output: html_document
---

This application is a mean for absolute car beginners (like myself) to investigate the fuel efficiency of various car models.  Even though there are other more accurate parameters for predicting the milage, they are not easily understood by beginners.  The choices in this application are meant to be intuitive options for consumers, not technical experts.  That is its value.

The data used in this application is the fuel efficiency of car models of the year 2010, 2011, and 2011.  These data are taken from the "AppliedPredictiveModeling" R package, which in turn collected the data from website http://fueleconomy.gov.

Interface Guide:
---------------------------
- The application is a web page containing of 2 panes.  The sidebar displays the options to specify for the vehicle, and the main pane displays the fuel efficiency.  A image of the selected model is also displayed in the main pane.  This image is not the exact configuration but a generic representation of the select model for use as reference.

- Select the options and the result in the main pane will show the milage.

- Help page is also accessible in application.

### Options:

- Model Year: Vehicle model year.
- Size Class: Compact Cars, Large Cars, Cargo Type Vans, ...
- Drive Configuration: Two Wheel Drive, Four Wheel Drive ...
- Number of Cylinder: Number of cylinder in vehicle engine.  2, 4, 8, ...  The default is 4

### Note:
- The represented image correspond to only the Size Class option, which will be blank if the "Other" choice is selected.
- If there is no vehicle in the database with the same Size Class and Drive Configuration, a message "This model configuration does not exist in the database" will be displayed instead of the mileage.  Other than that, fuel efficiency is predicted using linear regression models.
