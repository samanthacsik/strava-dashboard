dateRange_dateRangeInput <- function(inputId) {
  dateRangeInput(inputId = inputId, label = "Select a date range:",
                 min = min(acts$start_date_local), max = max(acts$start_date_local),
                 start = min(acts$start_date_local), end = max(acts$start_date_local))
}

dateRange_sliderInput <- function(inputId) {
  sliderInput(inputId = "date", label = "Select a date range:",
              min = min(acts$start_date_local),
              max = max(acts$start_date_local),
              value = c(min(acts$start_date_local, max(acts$start_date_local))))
}

dateRange_airDatepickerInput <- function(inputId) {
  airDatepickerInput(inputId = inputId, label = "Select a date range:",
                     maxDate = max(acts$start_date_local), minDate = min(acts$start_date_local),
                     value = c(min(acts$start_date_local), max(acts$start_date_local)),
                     range = TRUE, clear = TRUE)
}
