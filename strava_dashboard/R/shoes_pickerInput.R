shoes_pickerInput <- function(inputId) {

  pickerInput(inputId = inputId, label = "Select shoes:",
              choices = c("Hoka Speedgoat" = "hoka",
                          "Danner Jag #4" = "danner4", "Lowa Renegade" = "lowa",
                          "Danner Jag #3 (retired)" = "danner3",
                          "Danner Jag #2 (retired)" = "danner2", "Danner Jag #1 (retired)" = "danner1"), #"Reebok Nano" = "nano"
              selected = "Hoka Speedgoat",
              multiple = FALSE)

}

