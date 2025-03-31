shoes_pickerInput <- function(inputId) {

  pickerInput(inputId = inputId,
              label = "Select shoes:",
              choices = c("Hoka Speedgoat 5 (#1; retired)" = "hoka1",
                          "Hoka Speedgoat 5 (#2)" = "hoka2",
                          "Hoka Speedgoat 6 (#3)" = "hoka3",
                          "Teva Hurricane XLT2" = "tevas",
                          "Danner Jag #4" = "danner4",
                          "Lowa Renegade" = "lowa",
                          "Danner Jag #3 (retired)" = "danner3",
                          "Danner Jag #2 (retired)" = "danner2",
                          "Danner Jag #1 (retired)" = "danner1"),
              selected = "hoka2",
              multiple = FALSE)

}

