bike_pickerInput <- function(inputId) {

  pickerInput(inputId = inputId, label = "Select bike:",
              choices = c("Canyon Grail 7 (gravel)" = "grail", "Tandemania (tandem road bike)" = "tandem", "Yeti (MTB)" = "yeti",
                          "Trek (MTB)" = "trek", "Cannondale (MTB)" = "cannondale"),
              selected = "Canyon Grail 7 (gravel)",
              multiple = FALSE)

}
