stravaData_DTdatatable <- function(input) {

  # filter data ----
  acts_trimmed <- acts |>
    select(`Activity Title` = name, `Sport` = sport_type_alt, `Date` = start_date_local,
           `Distance Traveled (miles)` = total_miles, `Elevation Gain (ft)` = elevation_gain_ft,
           `Highest Elevation (ft)` = elev_high_ft, `Lowest Elevation (ft)` = elev_low_ft,
           `Average Speed (miles/hr)` = avg_speed_mi_hr, `Max Speed (miles/hr)` = max_speed_mi_hr,
           `Moving Time` = moving_time_hrs_mins, `Elapsed Time` = elapsed_time_hrs_mins,
           `Achievement Count` = achievement_count, `PR Count` = pr_count,) |>
    mutate(`Moving Time` = as.character(`Moving Time`),
           `Elapsed Time` = as.character(`Elapsed Time`))

  # render datatable ----
  DT::renderDataTable({
    DT::datatable(acts_trimmed,
                  options = list(pageLength = 10, scrollX = TRUE),
                  rownames = FALSE
    )
  })

}
