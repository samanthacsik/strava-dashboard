sport_type_pickerInput <- function(inputId) {
  pickerInput(inputId = inputId, label = "Select an activity:",
              choices = c("Hike", "Bike" = "Ride", "Walk"),
              options = pickerOptions(actionsBox = TRUE),
              selected = c("Hike", "Bike" = "Ride", "Walk"),
              multiple = T)
}
