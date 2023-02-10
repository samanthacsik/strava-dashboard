shoes_pickerInput <- function(inputId) {

  pickerInput(inputId = inputId, label = "Select shoes:",
              choices = c("Danner Jag #4" = "danner4", "Danner Jag #3" = "danner3", "Danner Jag #2" = "danner2", "Danner Jag #1 (retired)" = "danner1",
                          "Lowa Renegade" = "lowa", "Reebok Nano (black/white)" = "nano"),
              selected = "Danner Jag #4",
              multiple = FALSE)

}

